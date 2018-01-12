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

ActiveRecord::Schema.define(version: 20180112055019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "booking_events", force: :cascade do |t|
    t.bigint "booking_id"
    t.string "bl_number", null: false
    t.string "steamship_line", null: false
    t.string "origin", null: false
    t.string "destination", null: false
    t.string "vessel", null: false
    t.string "voyage", null: false
    t.datetime "vessel_eta", null: false
    t.string "event_changes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_events_on_booking_id"
  end

  create_table "booking_interests", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "user_id"
    t.boolean "watch"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_id"], name: "index_booking_interests_on_booking_id"
    t.index ["user_id"], name: "index_booking_interests_on_user_id"
  end

  create_table "bookings", force: :cascade do |t|
    t.string "bl_number", null: false
    t.string "steamship_line", null: false
    t.string "origin", null: false
    t.string "destination", null: false
    t.string "vessel", null: false
    t.string "voyage", null: false
    t.datetime "vessel_eta", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "watch"
  end

  create_table "containers", force: :cascade do |t|
    t.bigint "booking_id"
    t.bigint "booking_event_id"
    t.string "number", null: false
    t.string "size", null: false
    t.string "container_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["booking_event_id"], name: "index_containers_on_booking_event_id"
    t.index ["booking_id"], name: "index_containers_on_booking_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
