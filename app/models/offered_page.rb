class OfferedPage < ActiveRecord::Base

  belongs_to :seam_stitch
  belongs_to :page_commit, class_name: :StitchCommit

  def page
    self.page_commit.stitch rescue nil
  end

  def passage
    self.page_commit.passage rescue nil
  end

end
