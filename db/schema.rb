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

ActiveRecord::Schema.define(:version => 20140604225111) do

  create_table "ad_platforms", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "ad_platforms", ["user_id"], :name => "index_ad_platforms_on_user_id"

  create_table "bars", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "token"
    t.string   "message"
    t.string   "link_text"
    t.string   "link_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "bars", ["token"], :name => "index_bars_on_token"
  add_index "bars", ["user_id"], :name => "index_bars_on_user_id"

  create_table "impressions", :force => true do |t|
    t.integer  "bar_id"
    t.datetime "created_at"
    t.string   "type"
  end

  add_index "impressions", ["bar_id"], :name => "index_impressions_on_bar_id"

  create_table "settings", :force => true do |t|
    t.integer  "bar_id"
    t.string   "bar_color"
    t.string   "text_color"
    t.string   "link_color"
    t.integer  "max_impressions_count", :default => 100
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "settings", ["bar_id"], :name => "index_settings_on_bar_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0,  :null => false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
