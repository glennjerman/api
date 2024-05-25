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

ActiveRecord::Schema[7.1].define(version: 2024_05_23_215215) do
  create_table "favorite_tasks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.index ["user_id"], name: "index_favorite_tasks_on_user_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "task_id"
    t.boolean "monday"
    t.boolean "tuesday"
    t.boolean "wednesday"
    t.boolean "thursday"
    t.boolean "friday"
    t.boolean "saturday"
    t.boolean "sunday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "favorite_task_id"
    t.index ["task_id"], name: "index_schedules_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "title"
    t.string "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "completed"
    t.integer "time_to_complete"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean "permanent"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
  end

  add_foreign_key "favorite_tasks", "users"
  add_foreign_key "schedules", "tasks"
  add_foreign_key "tasks", "users"
end
