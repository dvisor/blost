class CreateSeamStitches < ActiveRecord::Migration
  def change
    create_table :seam_stitches do |t|
      t.integer :seam_id
      t.integer :stitch_id
      t.integer :prev_seam_stitch_id
      t.integer :next_seam_stitch_id

      t.timestamps
    end
  end
end
