class CreateOfferedPages < ActiveRecord::Migration
  def change
    create_table :offered_pages do |t|
      t.integer :page_commit_id
      t.integer :seam_stitch_id

      t.timestamps
    end
  end
end
