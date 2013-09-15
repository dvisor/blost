class SeamStitch < ActiveRecord::Base

  belongs_to :seam
  belongs_to :page_commit

  belongs_to :prev_seam_stitch, class_name: :SeamStitch
  belongs_to :next_seam_stitch, class_name: :SeamStitch

  has_many :seam_stitch_branches
  has_many :branches, through: :seam_stitch_branches

  has_many :offered_pages


  def self.standardize(seam_stitch_id)
    begin
      seam_stitch = self.find(seam_stitch_id)
    rescue ActiveRecord::RecordNotFound
      return nil
    end

    {data: {seam_stitch_id => seam_stitch.jsonize}, order: [seam_stitch_id]}
  end


  def jsonize
    data = {id: self.id}

    data[:passage] = self.page_commit.passage rescue nil

    data[:offered_pages] = {
      total: self.offered_pages.count,
      data: self.offered_pages.map do |offered_page|
        {
          id: offered_page.id,
          passage: offered_page.passage
        }
      end
    }

    data[:branches] = {
      total: self.branches.count,
      data: self.branches.map do |branch|
        {
          id: branch.id,
          passage: (branch.passage rescue nil)
        }
      end
    }

    return data

  end





  def passage
    page_commit.passage rescue nil
  end

  # def branches
  #   if self.next_seam_stitch_id.nil?
  #     SeamStitch.where(prev_seam_stitch_id: self.id)
  #   else
  #     SeamStitch.where(prev_seam_stitch_id: self.id).where('seam_stitches.id != ?', self.next_seam_stitch_id)
  #   end
  # end

  def branch(options={})
    puts "#{self.class.name}.#{__method__}"
    puts options.inspect
    
    seam.branch(self.id, options)
    if seam.errors.present?
      puts seam.errors.inspect
      self.errors.add(:branch, "Unable to branch")
    end


  end

  def retrieve(options={})

    puts options.inspect

    prev_count = options[:prev].to_i rescue nil
    prev_valid = !options[:prev].nil? && (prev_count.is_a? Integer)
    next_count = options[:next].to_i rescue nil
    next_valid = !options[:next].nil? && (next_count.is_a? Integer)

    jsonize = options[:jsonize]
    # standardize = options[:standardize]
    include_origin = options[:include_origin]

    puts next_count
    puts prev_count
    if !next_valid
      next_count = prev_valid ? (prev_count * -1) : 1
    end

    puts next_count

    data = {}
    order = []

    if include_origin
      data[self.id] = jsonize ? self.jsonize : self
      order.push(self.id)
    end

    current = self
    if next_count < 0
      prev_ss = current.prev_seam_stitch
      while prev_ss && next_count != 0
        data[prev_ss.id] = jsonize ? prev_ss.jsonize : prev_ss
        order.push(prev_ss.id)
        current = prev_ss
        prev_ss = current.prev_seam_stitch
        next_count += 1
      end
    else
      next_ss = current.next_seam_stitch
      while next_ss && next_count != 0
        data[next_ss.id] = jsonize ? next_ss.jsonize : next_ss
        order.push(next_ss.id)
        current = next_ss
        next_ss = current.next_seam_stitch
        next_count -= 1
      end
    end

    return {data: data, order: order}

  end

end
