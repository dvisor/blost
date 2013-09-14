# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130914182318) do

  create_table "git_objects", force: true do |t|
    t.string   "sha1"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offered_pages", force: true do |t|
    t.integer  "page_commit_id"
    t.integer  "seam_stitch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "page_commits", force: true do |t|
    t.integer  "page_id"
    t.integer  "git_object_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", force: true do |t|
    t.integer  "author_id"
    t.integer  "source_page_commit_id"
    t.integer  "page_commit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seam_stitch_branches", force: true do |t|
    t.integer  "branch_seam_stitch_id"
    t.integer  "seam_stitch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seam_stitches", force: true do |t|
    t.integer  "seam_id"
    t.integer  "page_commit_id"
    t.integer  "prev_seam_stitch_id"
    t.integer  "next_seam_stitch_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seams", force: true do |t|
    t.string   "title"
    t.integer  "start_seam_stitch_id"
    t.integer  "end_seam_stitch_id"
    t.integer  "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
