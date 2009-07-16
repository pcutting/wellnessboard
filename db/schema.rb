# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090716035036) do

  create_table "blogs", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "post"
    t.integer  "total_score"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "body_scans", :force => true do |t|
    t.integer  "user_id"
    t.integer  "water"
    t.integer  "metabolism"
    t.integer  "visc"
    t.integer  "fat"
    t.integer  "muscle"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "catalogs", :force => true do |t|
    t.string   "sku"
    t.string   "item"
    t.string   "description"
    t.string   "picture"
    t.string   "price"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.text     "response"
    t.integer  "total_score"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "order_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "exercises", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "length",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "calories"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "foods", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "calories"
    t.integer  "protein"
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "goals", :force => true do |t|
    t.integer  "user_id"
    t.integer  "weight",         :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "chest",          :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "belly_upper",    :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "belly_lower",    :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "hips",           :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "thigh",          :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "arm",            :limit => 10, :precision => 10, :scale => 0, :default => 0
    t.integer  "water",                                                       :default => 64
    t.integer  "steps_daily",                                                 :default => 3000
    t.integer  "daily_calories",                                              :default => 1250
    t.datetime "date",                                                        :default => '2009-06-28 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "homes", :force => true do |t|
    t.string   "option"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "chart_type"
    t.integer  "time_span_days"
  end

  create_table "items", :force => true do |t|
    t.integer  "order_id"
    t.string   "sku"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "measurements", :force => true do |t|
    t.integer  "user_id"
    t.integer  "chest",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "belly_upper", :limit => 10, :precision => 10, :scale => 0
    t.integer  "belly_lower", :limit => 10, :precision => 10, :scale => 0
    t.integer  "hips",        :limit => 10, :precision => 10, :scale => 0
    t.integer  "thigh",       :limit => 10, :precision => 10, :scale => 0
    t.integer  "arm",         :limit => 10, :precision => 10, :scale => 0
    t.datetime "date",                                                     :default => '2009-06-28 00:00:00'
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_exercises", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.integer  "length",     :limit => 10, :precision => 10, :scale => 0
    t.integer  "calories"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "my_foods", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "calories"
    t.integer  "protein"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offer_accesses", :force => true do |t|
    t.integer  "promotion_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offer_restrictions", :force => true do |t|
    t.integer  "promotion_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offer_skus", :force => true do |t|
    t.integer  "promotion_id"
    t.string   "sku"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "shipping_address"
    t.string   "shipping_city"
    t.string   "shipping_state"
    t.string   "shipping_zip"
    t.string   "billing_address"
    t.string   "billing_city"
    t.string   "billing_state"
    t.string   "billing_zip"
    t.string   "sponsor"
    t.string   "coach"
    t.string   "referred_by"
    t.string   "phone"
    t.string   "alt_phone"
    t.integer  "hight_feet"
    t.integer  "hight_inches"
    t.string   "time_zone"
    t.string   "nick_name"
    t.string   "name_first"
    t.string   "middle_initial"
    t.string   "name_last"
    t.string   "sufix"
    t.date     "dob"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "promotions", :force => true do |t|
    t.string   "code"
    t.integer  "offer_sku_id"
    t.integer  "percent"
    t.boolean  "accumulative"
    t.boolean  "all_access"
    t.integer  "offer_restriction_id"
    t.integer  "offer_access_id"
    t.datetime "start"
    t.datetime "end"
    t.text     "description"
    t.integer  "sponsor_id"
    t.boolean  "all_sponsors"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quick_facts", :force => true do |t|
    t.string   "category"
    t.string   "title"
    t.text     "summary"
    t.string   "reference"
    t.integer  "total_score"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quick_supports", :force => true do |t|
    t.integer  "user_id"
    t.integer  "priority"
    t.string   "title"
    t.text     "details"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "shake_recipes", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "calories"
    t.string   "protein"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sponsors", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "motto"
    t.text     "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "testimonies", :force => true do |t|
    t.string   "photo"
    t.string   "name"
    t.string   "layout"
    t.boolean  "public"
    t.string   "title"
    t.text     "comment"
    t.integer  "points"
    t.integer  "votes"
    t.integer  "before"
    t.integer  "after"
    t.integer  "display_value"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "current_login_at"
    t.datetime "last_request_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "waters", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.integer  "ounces"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weights", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.integer  "weight",     :limit => 10, :precision => 10, :scale => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
