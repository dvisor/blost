class SeamStitch < ActiveRecord::Base

  belongs_to :seam
  belongs_to :stitch

  belongs_to :prev_seam_stitch, class_name: :SeamStitch
  belongs_to :next_seam_stitch, class_name: :SeamStitch

  has_many :seam_stitch_branches
  has_many :branches, through: :seam_stitch_branches

  def pages
    []
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

    prev_count = options[:prev].to_i rescue nil
    prev_valid = !options[:prev].nil? && (prev_count.is_a? Integer)
    next_count = options[:next].to_i rescue nil
    next_valid = !options[:next].nil? && (next_count.is_a? Integer)

    puts next_count
    puts prev_count
    if !next_valid
      next_count = prev_valid ? (prev_count * -1) : 1
    end

    puts next_count

    retrieved = []
    current = self
    if next_count < 0
      while current.prev_seam_stitch && next_count != 0
        retrieved.push(prev_seam_stitch)
        current = prev_seam_stitch
        next_count += 1
      end
    else
      while current.next_seam_stitch && next_count != 0
        retrieved.push(next_seam_stitch)
        current = next_seam_stitch
        next_count -= 1
      end
    end

    return retrieved

  end

end