# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_12_080204) do
  create_table "books", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "title"
    t.string "author"
    t.integer "category"
    t.string "details"
    t.boolean "deleted", default: false
    t.bigint "user_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_books_on_category_id"
    t.index ["user_id"], name: "index_books_on_user_id"
  end

  create_table "categories", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "donations", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "details"
    t.integer "process_status"
    t.boolean "deleted", default: false
    t.bigint "sending_user_id", null: false
    t.bigint "receiving_user_id"
    t.bigint "sended_book_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiving_user_id"], name: "index_donations_on_receiving_user_id"
    t.index ["sended_book_id"], name: "index_donations_on_sended_book_id"
    t.index ["sending_user_id"], name: "index_donations_on_sending_user_id"
  end

  create_table "exchanges", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "process_status"
    t.integer "type_of_exchange"
    t.string "details"
    t.boolean "deleted", default: false
    t.bigint "sending_user_id", null: false
    t.bigint "receiving_user_id"
    t.bigint "sended_book_id", null: false
    t.bigint "received_book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["received_book_id"], name: "index_exchanges_on_received_book_id"
    t.index ["receiving_user_id"], name: "index_exchanges_on_receiving_user_id"
    t.index ["sended_book_id"], name: "index_exchanges_on_sended_book_id"
    t.index ["sending_user_id"], name: "index_exchanges_on_sending_user_id"
  end

  create_table "requests", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "status"
    t.string "details"
    t.boolean "deleted", default: false
    t.bigint "request_user_id", null: false
    t.bigint "request_book_id", null: false
    t.bigint "exchange_requested_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exchange_requested_id"], name: "index_requests_on_exchange_requested_id"
    t.index ["request_book_id"], name: "index_requests_on_request_book_id"
    t.index ["request_user_id"], name: "index_requests_on_request_user_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "city"
    t.string "county"
    t.boolean "deleted", default: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "books", "categories"
  add_foreign_key "books", "users"
  add_foreign_key "donations", "books", column: "sended_book_id"
  add_foreign_key "donations", "users", column: "receiving_user_id"
  add_foreign_key "donations", "users", column: "sending_user_id"
  add_foreign_key "exchanges", "books", column: "received_book_id"
  add_foreign_key "exchanges", "books", column: "sended_book_id"
  add_foreign_key "exchanges", "users", column: "receiving_user_id"
  add_foreign_key "exchanges", "users", column: "sending_user_id"
  add_foreign_key "requests", "books", column: "request_book_id"
  add_foreign_key "requests", "exchanges", column: "exchange_requested_id"
  add_foreign_key "requests", "users", column: "request_user_id"
end
