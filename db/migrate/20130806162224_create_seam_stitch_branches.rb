class CreateSeamStitchBranches < ActiveRecord::Migration
  def change
    create_table :seam_stitch_branches do |t|
      t.integer :branch_seam_stitch_id
      t.integer :seam_stitch_id

      t.timestamps
    end
  end
end
