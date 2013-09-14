class RenameSeamStitchColumn < ActiveRecord::Migration
  def change
    rename_column :seam_stitches, :stitch_id, :page_commit_id
  end
end
