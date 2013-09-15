class AddUpSeamIdToSeam < ActiveRecord::Migration
  def change
    add_column :seams, :up_seam_id, :integer
  end
end
