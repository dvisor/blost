class RenameUpSeamIdToParentSeamId < ActiveRecord::Migration
  def change
    rename_column :seams, :up_seam_id, :parent_seam_id
  end
end
