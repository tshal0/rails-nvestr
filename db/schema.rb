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

ActiveRecord::Schema.define(version: 20170325205415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "portfolios", force: :cascade do |t|
    t.string   "portfolio_name"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.decimal  "portfolio_cash_account"
  end

  create_table "positions", force: :cascade do |t|
    t.decimal  "position_amount"
    t.integer  "stock_id"
    t.integer  "portfolio_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "role_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stocks", force: :cascade do |t|
    t.string   "stock_name"
    t.string   "stock_symbol"
    t.decimal  "stock_price"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "trade_types", force: :cascade do |t|
    t.string   "trade_type_name"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "trades", force: :cascade do |t|
    t.decimal  "trade_amount"
    t.decimal  "trade_price"
    t.datetime "trade_datetime"
    t.integer  "stock_id"
    t.integer  "position_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "trade_type"
  end

  create_table "user_to_roles", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
