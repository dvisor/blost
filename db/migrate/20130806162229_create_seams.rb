class CreateSeams < ActiveRecord::Migration
  def change
    create_table :seams do |t|
      t.string :title
      t.integer :start_seam_stitch_id
      t.integer :end_seam_stitch_id
      t.integer :author_id

      t.timestamps
    end
  end
end
