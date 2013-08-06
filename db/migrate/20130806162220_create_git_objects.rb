class CreateGitObjects < ActiveRecord::Migration
  def change
    create_table :git_objects do |t|
      t.string :sha1
      t.text :content

      t.timestamps
    end
  end
end
