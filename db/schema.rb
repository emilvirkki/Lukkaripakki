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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120411093141) do

  create_table "nav_items", :force => true do |t|
    t.string   "title"
    t.string   "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "priority"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "nav_item_id"
  end

  create_table "songs", :force => true do |t|
    t.string   "name"
    t.text     "lyrics"
    t.text     "extra_lyrics"
    t.text     "introduction"
    t.string   "songbook_number"
    t.string   "melody"
    t.string   "lyrics_author"
    t.text     "keywords"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
