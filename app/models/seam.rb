class Seam < ActiveRecord::Base

  belongs_to :start_seam_stitch, class_name: :SeamStitch
  belongs_to :end_seam_stitch, class_name: :SeamStitch

  has_many :seam_stitches
  has_many :stitches, through: :seam_stitches

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
    when StitchCommit
    when Stitch
      page_commit = page_commit.stitch_commit
      if page_commit.nil?
        return nil
      end
    when String
      page_commit = Stitch.create(passage: page_commit).stitch_commit
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
    # -- Create new stitch
    stitch = Stitch.create(passage: options[:passage])

    if stitch.errors.present?
      puts stitch.errors.inspect
      self.errors.add(:branch, "Unable to branch")
    else
      new_seam = Seam.create();
      new_seam_stitch = new_seam.push(stitch);
      if new_seam_stitch
        SeamStitchBranch.create(seam_stitch_id: seam_stitch_id, branch_seam_stitch_id: new_seam_stitch.id)
      else
        puts new_seam.errors.inspect
        new_seam.errors.add(:branch, "Unable to branch")
      end

    end

  end

end
