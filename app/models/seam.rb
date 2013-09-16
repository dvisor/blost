class Seam < ActiveRecord::Base

  belongs_to :start_seam_stitch, class_name: :SeamStitch
  belongs_to :end_seam_stitch, class_name: :SeamStitch

  has_many :seam_stitches
  # has_many :stitches, through: :seam_stitches

  def self.trunks
    where(parent_seam_id: nil)
  end

  def self.standardize(seam_id)
    begin
      seam = self.find(seam_id)
    rescue ActiveRecord::RecordNotFound
      return nil
    end

    {data: {seam_id => seam.jsonize}, order: [seam_id]}
  end

  def jsonize
    data = {id: self.id}

    data[:title] = self.title

    return data
  end

  def standardized(options={})

    seam_stitch_options = options[:seam_stitch].is_a?(Hash) ? Utilities.deep_dup(options[:seam_stitch]) : {}

    seam_stitch_retrieve_options = seam_stitch_options[:retrieve] = seam_stitch_options[:retrieve].is_a?(Hash) ? seam_stitch_options[:retrieve] : {}

    seam_stitch_standardize_options = seam_stitch_options[:standardize] = seam_stitch_options[:standardize].is_a?(Hash) ? seam_stitch_options[:standardize] : {}

    origin_seam_stitch = SeamStitch.find_by_id(seam_stitch_retrieve_options[:origin_id])

    if origin_seam_stitch.blank?
      origin_seam_stitch_id = self.end_seam_stitch_id
      origin_seam_stitch = SeamStitch.find_by_id(origin_seam_stitch_id)
      seam_stitch_standardize_options[:active_ids] = [origin_seam_stitch_id]
      seam_stitch_retrieve_options[:origin_id] = origin_seam_stitch_id
      seam_stitch_retrieve_options[:include_origin] = true
      seam_stitch_retrieve_include_origin = true
      seam_stitch_retrieve_options[:next] = 0
      seam_stitch_retrieve_options[:prev] = 0
    end

    seam_stitch_retrieve_options[:jsonize] = true
    # seam_stitch_retrieve_options[:standardize] = true


    return_data = {}

    return_data[:seam] = StandardData.enhance!(Seam.standardize(self.id), {active_ids: [self.id]})
    return_data[:seam_stitch] = StandardData.enhance!(
      origin_seam_stitch.retrieve(seam_stitch_retrieve_options),
      seam_stitch_standardize_options)

    # data = {}
    # order = []
    # if seam_stitch
    #   active_id = seam_stitch.id
    #   active_index = 0
    #   data[seam_stitch.id] = seam_stitch.jsonize
    #   order.push(seam_stitch.id)
    # else
    #   active_id = nil
    #   active_index = nil
    # end

    # return_data[:seam_stitch] = {
    #   active_id: active_id,
    #   active_index: active_index,
    #   data: data,
    #   order: order
    # }

    return return_data
  end

  def push(page_commit)
    puts "#{self.class.name}.#{__method__}"

    # prev_seam_stitch_id = self.end_seam_stitch_id
    # # -- Create new seam stitch that is positioned after last stitch.
    # new_seam_stitch = SeamStitch.create(seam_id: self.id, page_commit_id: page_commit.id, prev_seam_stitch_id: prev_seam_stitch_id)
    
    # if new_seam_stitch.errors.present?
    #   return nil
    # else
    #   prev_seam_stitch = new_seam_stitch.prev_seam_stitch
    #   if prev_seam_stitch
    #     # -- Previous seam stitch exists.
    #     # -- Have previous point to new.
    #     prev_seam_stitch.update_attribute(:next_seam_stitch_id, new_seam_stitch.id)
    #   end

    #   if !self.start_seam_stitch_id
    #     # -- No start seam stitch - new must be first - set new as start.
    #     self.start_seam_stitch_id = new_seam_stitch.id
    #   end

    #   # -- Set new as end seam stitch.
    #   self.end_seam_stitch_id = new_seam_stitch.id
    #   self.save

    #   return new_seam_stitch
    # end

    self.insert(nil, page_commit, {position: :after})
  end

  def insert(target_seam_stitch_id, page_commit, options={})
    puts "#{self.class.name}.#{__method__}"

    puts self.inspect

    puts "start #{start_seam_stitch_id} #{self.start_seam_stitch_id}"
    puts "end #{end_seam_stitch_id} #{self.end_seam_stitch_id}"

    target_seam_stitch = nil
    prev_seam_stitch_id = nil
    next_seam_stitch_id = nil

    position_after = options[:position].to_s == "after" rescue false

    case page_commit
    when PageCommit
    when Page
      page_commit = page_commit.page_commit
      if page_commit.nil?
        return nil
      end
    when String
      page_commit = Page.create(passage: page_commit).page_commit
    else
      return nil
    end


    if target_seam_stitch_id.nil?
      target_seam_stitch = self.start_seam_stitch
    else
      target_seam_stitch = SeamStitch.find_by_id(target_seam_stitch_id)
      if target_seam_stitch.nil? || target_seam_stitch.seam_id != self.id
        return nil
      end
    end

    # if target_seam_stitch && target_seam_stitch.seam_id == self.id
      # -- Target exists and belongs to this seam.
    puts "target: "
    puts target_seam_stitch.inspect

    if target_seam_stitch.nil?
      if position_after
        prev_seam_stitch_id = self.end_seam_stitch_id
        next_seam_stitch_id = nil
      else
        prev_seam_stitch_id = nil
        next_seam_stitch_id = self.start_seam_stitch_id
      end
    else
      if position_after
        # -- Establish prev and next for new seam stitch.
        prev_seam_stitch_id = target_seam_stitch.id
        next_seam_stitch_id = target_seam_stitch.next_seam_stitch_id
      else
        # -- Establish prev and next for new seam stitch.
        prev_seam_stitch_id = target_seam_stitch.prev_seam_stitch_id
        next_seam_stitch_id = target_seam_stitch.id
      end
    end

    puts "prev ss: #{prev_seam_stitch_id} next ss: #{next_seam_stitch_id}"

    # -- Create new seam stitch that is positioned before target.
    new_seam_stitch = SeamStitch.create(seam_id: self.id, page_commit_id: page_commit.id, prev_seam_stitch_id: prev_seam_stitch_id, next_seam_stitch_id: next_seam_stitch_id)
    if !new_seam_stitch.errors.present?
      # -- No errors.

      # -- Have target point back to new.
      # target_seam_stitch.update_attribute(:prev_seam_stitch_id, new_seam_stitch.id)

      prev_seam_stitch = new_seam_stitch.prev_seam_stitch
      if prev_seam_stitch
        # -- Previous seam stitch exists.
        # -- Have previous point to new.
        prev_seam_stitch.update_attribute(:next_seam_stitch_id, new_seam_stitch.id)
      else
        self.update_attribute(:start_seam_stitch_id, new_seam_stitch.id)
      end

      next_seam_stitch = new_seam_stitch.next_seam_stitch
      if next_seam_stitch
        # -- Next seam stitch exists.
        # -- Have next point to new.
        next_seam_stitch.update_attribute(:prev_seam_stitch_id, new_seam_stitch.id)
      else
        self.update_attribute(:end_seam_stitch_id, new_seam_stitch.id)
      end

      # if self.start_seam_stitch_id == target_seam_stitch_id
      #     # -- Target is start seam stitch - new is before target - set new as start.
      #   self.start_seam_stitch_id = new_seam_stitch.id
      #   self.save
      # end

      return new_seam_stitch
    end


    return nil

  end



  def branch(seam_stitch_id, options={})
    puts "#{self.class.name}.#{__method__}"
    puts options.inspect
    puts options[:passage]

    parent_seam_stitch = SeamStitch.find_by_id(seam_stitch_id)
    valid_parent_seam_stitch = parent_seam_stitch

    if !valid_parent_seam_stitch
      self.errors.add(:branch, "Unable to branch - invalid parent seam stitch")
      return nil
    end

    # -- Create new stitch
    page = Page.create(passage: options[:passage])

    if page.errors.present?
      puts page.errors.inspect
      self.errors.add(:branch, "Unable to branch")
    else
      new_seam = Seam.create(parent_seam_id: parent_seam_stitch.seam_id);
      new_seam_stitch = new_seam.push(page);
      if new_seam_stitch
        SeamStitchBranch.create(seam_stitch_id: seam_stitch_id, branch_seam_stitch_id: new_seam_stitch.id)
      else
        puts new_seam.errors.inspect
        new_seam.errors.add(:branch, "Unable to branch")
      end

    end

  end

end
