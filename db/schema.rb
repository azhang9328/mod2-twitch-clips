# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 6) do

  create_table "clips", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "view_count"
    t.string "date_clipped"
    t.integer "streamer_id"
    t.integer "game_id"
    t.datetime "corf"
  end

  create_table "favorite_clips", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.integer "view_count"
    t.string "date_clipped"
    t.integer "streamer_id"
    t.integer "game_id"
    t.integer "user_id"
    t.integer "clip_id"
    t.datetime "corf"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.string "img_url"
    t.integer "tw_id"
    t.datetime "corf"
  end

  create_table "streamers", force: :cascade do |t|
    t.string "username"
    t.integer "tw_id"
    t.string "broadcaster_type"
    t.string "description"
    t.string "profile_img_url"
    t.integer "view_count"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

  create_table "users_games", force: :cascade do |t|
    t.integer "user_id"
    t.integer "game_id"
  end

end
