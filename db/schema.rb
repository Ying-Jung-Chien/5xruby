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

ActiveRecord::Schema[7.0].define(version: 2022_08_31_140940) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tags", force: :cascade do |t|
    t.integer "task_id"
    t.string "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["task_id"], name: "index_tags_on_task_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.integer "user_id"
    t.string "header", null: false
    t.text "content", null: false
    t.integer "priority", null: false
    t.integer "status", null: false
    t.datetime "start_time", precision: nil, null: false
    t.datetime "end_time", precision: nil, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["content"], name: "index_tasks_on_content"
    t.index ["header"], name: "index_tasks_on_header"
    t.index ["status"], name: "index_tasks_on_status"
    t.index ["user_id"], name: "index_tasks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "password_digest", null: false
    t.string "position", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
