class OfferedPage < ActiveRecord::Base

  belongs_to :seam_stitch
  belongs_to :page_commit

  def page
    self.page_commit.page rescue nil
  end

  def passage
    self.page_commit.passage rescue nil
  end

end
