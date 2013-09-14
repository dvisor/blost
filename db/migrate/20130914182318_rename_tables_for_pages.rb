class RenameTablesForPages < ActiveRecord::Migration
  def change
    rename_table :stitches, :pages
    rename_column :pages, :source_stitch_commit_id, :source_page_commit_id
    rename_column :pages, :stitch_commit_id, :page_commit_id

    rename_table :stitch_commits, :page_commits
    rename_column :page_commits, :stitch_id, :page_id

  end
end
