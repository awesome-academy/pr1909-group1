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

ActiveRecord::Schema.define(version: 2020_05_07_125635) do

  create_table "apply_activities", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "candidate_id", null: false
    t.bigint "job_post_id", null: false
    t.bigint "employer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["candidate_id"], name: "index_apply_activities_on_candidate_id"
    t.index ["employer_id"], name: "index_apply_activities_on_employer_id"
    t.index ["job_post_id"], name: "index_apply_activities_on_job_post_id"
  end

  create_table "candidates", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date_of_birth"
    t.string "phone", limit: 16
    t.string "avatar"
    t.string "cv"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_candidates_on_deleted_at"
    t.index ["user_id"], name: "index_candidates_on_user_id"
  end

  create_table "ckeditor_assets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "employers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "company_logo"
    t.string "company_name", limit: 70, null: false
    t.string "company_size", limit: 20, null: false
    t.text "company_description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_employers_on_deleted_at"
    t.index ["user_id"], name: "index_employers_on_user_id"
  end

  create_table "job_posts", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "employer_id", null: false
    t.integer "job_location", null: false
    t.integer "job_type", null: false
    t.integer "job_status", default: 1, null: false
    t.integer "post_priority", default: 5, null: false
    t.integer "salary_min", default: 0, null: false
    t.integer "salary_max", default: 1
    t.string "post_title", limit: 100, null: false
    t.text "job_description", null: false
    t.date "job_expired_date", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["employer_id"], name: "index_job_posts_on_employer_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name", limit: 20, null: false
    t.string "last_name", limit: 15, null: false
    t.integer "user_type", null: false
    t.datetime "deleted_at"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "apply_activities", "candidates"
  add_foreign_key "apply_activities", "job_posts"
  add_foreign_key "apply_activities", "job_posts", column: "employer_id"
  add_foreign_key "candidates", "users"
  add_foreign_key "employers", "users"
  add_foreign_key "job_posts", "employers"
end
