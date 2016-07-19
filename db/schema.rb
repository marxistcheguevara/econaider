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

ActiveRecord::Schema.define(version: 16) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "business_indices", force: :cascade do |t|
    t.string   "name"
    t.decimal  "inc_rate"
    t.string   "text_fitness"
    t.string   "text_education"
    t.string   "text_bookstore"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "factors", force: :cascade do |t|
    t.integer  "economic_year"
    t.decimal  "inflation_rate"
    t.decimal  "tax_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "credit_percentage_rate"
    t.decimal  "discount_rate"
    t.decimal  "optimistic_rate"
    t.decimal  "pessimistic_rate"
  end

  create_table "lines", force: :cascade do |t|
    t.string   "name"
    t.integer  "p_index"
    t.integer  "cs_index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "needs", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", force: :cascade do |t|
    t.string   "name"
    t.integer  "rprice_per_sq_feet"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "percentage"
  end

  create_table "services", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_id"
    t.integer  "increase_constraint"
  end

  create_table "staffs", force: :cascade do |t|
    t.string   "name"
    t.integer  "wage"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "strategies", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "line_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
