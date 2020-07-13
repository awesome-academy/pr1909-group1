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

ActiveRecord::Schema.define(version: 2020_06_26_172348) do

  create_table "ckeditor_assets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "comment_lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "user_id", null: false
    t.string "content", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_comment_lessons_on_lesson_id"
    t.index ["user_id"], name: "index_comment_lessons_on_user_id"
  end

  create_table "course_types", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "course_type", limit: 50, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "course_title", limit: 100, null: false
    t.text "course_overview", null: false
    t.text "course_description", null: false
    t.string "course_image"
    t.string "overview_video_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_type_id", null: false
    t.integer "total_likes_count", default: 0
    t.integer "total_registers_count", default: 0
    t.index ["course_type_id"], name: "index_courses_on_course_type_id"
    t.index ["user_id"], name: "index_courses_on_user_id"
  end

  create_table "lessons", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.string "lesson_name", null: false
    t.integer "lesson_type", default: 1, null: false
    t.integer "lesson_sequence", default: 1, null: false
    t.string "video_url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_lessons_on_course_id"
  end

  create_table "likes", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "discarded_at"
    t.index ["course_id"], name: "index_likes_on_course_id"
    t.index ["discarded_at"], name: "index_likes_on_discarded_at"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "quiz_questions", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.string "quiz_question"
    t.json "quiz_choice"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_quiz_questions_on_lesson_id"
  end

  create_table "quiz_results", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "lesson_id", null: false
    t.bigint "user_id", null: false
    t.integer "mark", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lesson_id"], name: "index_quiz_results_on_lesson_id"
    t.index ["user_id"], name: "index_quiz_results_on_user_id"
  end

  create_table "registers", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "course_id", null: false
    t.bigint "user_id", null: false
    t.integer "lesson_step", default: 1, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id", "user_id"], name: "index_registers_on_course_id_and_user_id", unique: true
    t.index ["course_id"], name: "index_registers_on_course_id"
    t.index ["user_id"], name: "index_registers_on_user_id"
  end

  create_table "review_courses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.text "comment", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_review_courses_on_course_id"
    t.index ["user_id"], name: "index_review_courses_on_user_id"
  end

  create_table "users", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "full_name", limit: 40, default: "", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "is_admin", default: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "refresh_token"
    t.datetime "oauth_expires_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comment_lessons", "lessons"
  add_foreign_key "comment_lessons", "users"
  add_foreign_key "courses", "course_types"
  add_foreign_key "courses", "users"
  add_foreign_key "lessons", "courses"
  add_foreign_key "likes", "courses"
  add_foreign_key "likes", "users"
  add_foreign_key "quiz_questions", "lessons"
  add_foreign_key "quiz_results", "lessons"
  add_foreign_key "quiz_results", "users"
  add_foreign_key "registers", "courses"
  add_foreign_key "registers", "users"
  add_foreign_key "review_courses", "courses"
  add_foreign_key "review_courses", "users"
end
