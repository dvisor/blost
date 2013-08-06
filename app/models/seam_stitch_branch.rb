class SeamStitchBranch < ActiveRecord::Base

  belongs_to :seam_stitch
  belongs_to :branch, class_name: :SeamStitch, foreign_key: :branch_seam_stitch_id
end
