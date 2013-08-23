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

ActiveRecord::Schema.define(:version => 20130524193522) do

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "weburl"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.integer  "price"
    t.boolean  "ongoing"
    t.datetime "startdate"
    t.datetime "enddate"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "coursetimes", :force => true do |t|
    t.integer  "course_id"
    t.time     "start"
    t.time     "end"
    t.string   "dayofweek"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "individuals", :force => true do |t|
    t.string   "firstname"
    t.string   "college"
    t.text     "hobbies"
    t.float    "gpa"
    t.text     "testscores"
    t.string   "major"
    t.string   "familyincome"
    t.text     "bio"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.string   "email"
    t.string   "token"
    t.string   "password_digest"
    t.text     "topics"
    t.string   "lastname"
    t.datetime "birthday"
    t.string   "gender"
    t.string   "futurehopesanddreams"
    t.text     "goalinlife"
    t.string   "academiclevel"
    t.string   "academicyear"
    t.string   "highschool"
    t.float    "highschoolgpa"
    t.integer  "satscore"
    t.integer  "satverbalscore"
    t.integer  "satmathscore"
    t.integer  "actscore"
    t.integer  "actmathscore"
    t.text     "ap"
    t.string   "mathclass"
    t.integer  "proficiencymath"
    t.integer  "proficiencyreading"
    t.integer  "proficiencyscience"
    t.integer  "proficiencysocialstudies"
    t.integer  "proficiencybusiness"
    t.integer  "proficiencyeconomics"
    t.integer  "proficiencymusic"
    t.integer  "proficiencyforeignlanguage"
    t.integer  "proficiencysports"
    t.integer  "proficiencycommunityservice"
    t.integer  "proficiencypublicspeaking"
    t.integer  "proficiencyleadership"
    t.integer  "proficiencydance"
    t.integer  "proficiencyart"
    t.integer  "proficiencyacting"
    t.text     "foreignlanguage"
    t.string   "hourlyrate"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phonenumber"
    t.string   "favoritecolor"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.integer  "details_id"
    t.string   "details_type"
    t.string   "weburl"
  end

  create_table "order_transactions", :force => true do |t|
    t.integer  "order_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "course_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.string   "email"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "purchasers", :force => true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "rates", :force => true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.integer  "stars",         :null => false
    t.string   "dimension"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "rates", ["rateable_id", "rateable_type"], :name => "index_rates_on_rateable_id_and_rateable_type"
  add_index "rates", ["rater_id"], :name => "index_rates_on_rater_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_digest"
    t.text     "topics"
    t.text     "bio"
    t.string   "token"
    t.string   "hourlyrate"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "phonenumber"
    t.string   "favoritecolor"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.integer  "details_id"
    t.string   "details_type"
    t.string   "slug"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "zipcode"
    t.boolean  "emailverified"
    t.boolean  "gmaps"
    t.string   "weburl"
    t.string   "url"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "feature",                :default => false
    t.integer  "priority",               :default => 100
    t.boolean  "display_address",        :default => true
    t.boolean  "display_phone",          :default => true
    t.boolean  "displayInfo",            :default => true
    t.boolean  "approved",               :default => false
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
