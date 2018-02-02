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

ActiveRecord::Schema.define(version: 20180129064343) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "client_name"
    t.string "client_address"
    t.string "client_contact_name"
    t.string "client_contact_email"
    t.string "client_contact_phone"
    t.string "client_notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jobs", force: :cascade do |t|
    t.string "job_client"
    t.string "job_address"
    t.string "job_date"
    t.string "job_time"
    t.integer "job_estimated_hours"
    t.string "job_sport"
    t.string "job_notes"
    t.string "job_completion_notes"
    t.string "job_start_time"
    t.string "job_end_time"
    t.integer "job_actual_hours", default: 0
    t.boolean "job_completed", default: false
    t.boolean "job_approved", default: false
    t.boolean "job_paid", default: false
    t.bigint "primary_id"
    t.bigint "backup_id"
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["backup_id"], name: "index_jobs_on_backup_id"
    t.index ["client_id"], name: "index_jobs_on_client_id"
    t.index ["primary_id"], name: "index_jobs_on_primary_id"
  end

  create_table "sports", force: :cascade do |t|
    t.string "sport_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "firstname"
    t.string "lastname"
    t.string "address"
    t.string "phone_number"
    t.integer "role", default: 2
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "jobs", "clients"
end
