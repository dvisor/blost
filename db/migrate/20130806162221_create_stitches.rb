class CreateStitches < ActiveRecord::Migration
  def change
    create_table :stitches do |t|
      t.integer :author_id
      t.integer :source_stitch_commit_id
      t.integer :stitch_commit_id

      t.timestamps
    end
  end
end
