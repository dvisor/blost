class CreateStitchCommits < ActiveRecord::Migration
  def change
    create_table :stitch_commits do |t|
      t.integer :stitch_id
      t.integer :git_object_id

      t.timestamps
    end
  end
end
