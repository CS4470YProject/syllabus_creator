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

ActiveRecord::Schema.define(version: 20160223044233) do

  create_table "categories", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "faculty_id", limit: 4
  end

  create_table "courses", force: :cascade do |t|
    t.string   "code",        limit: 255
    t.integer  "number",      limit: 4
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "element_groups", force: :cascade do |t|
    t.integer  "rank",       limit: 4
    t.integer  "outline_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "element_rules", force: :cascade do |t|
    t.integer  "element_id", limit: 4
    t.integer  "rule_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "element_rules", ["element_id"], name: "index_element_rules_on_element_id", using: :btree
  add_index "element_rules", ["rule_id"], name: "index_element_rules_on_rule_id", using: :btree

  create_table "elements", force: :cascade do |t|
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.text     "text",             limit: 65535
    t.integer  "rank",             limit: 4,     default: 0
    t.integer  "element_group_id", limit: 4
  end

  create_table "faculties", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "parent_id",  limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "headers", force: :cascade do |t|
    t.string   "text",             limit: 255
    t.boolean  "bold",                         default: false
    t.boolean  "italic",                       default: false
    t.boolean  "underline",                    default: false
    t.integer  "size",             limit: 4
    t.integer  "element_id",       limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.integer  "element_group_id", limit: 4
  end

  create_table "job_messengers", force: :cascade do |t|
    t.string   "job_id",     limit: 255
    t.string   "status",     limit: 255
    t.string   "message",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "job_messengers", ["job_id"], name: "index_job_messengers_on_job_id", using: :btree

  create_table "outline_elements", force: :cascade do |t|
    t.integer  "outline_id", limit: 4
    t.integer  "element_id", limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "order",      limit: 4
  end

  add_index "outline_elements", ["element_id"], name: "index_outline_elements_on_element_id", using: :btree
  add_index "outline_elements", ["outline_id"], name: "index_outline_elements_on_outline_id", using: :btree

  create_table "outlines", force: :cascade do |t|
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "course_id",   limit: 4
    t.string   "type",        limit: 255
    t.integer  "parent_id",   limit: 4
    t.integer  "category_id", limit: 4
  end

  add_index "outlines", ["course_id"], name: "index_outlines_on_course_id", using: :btree
  add_index "outlines", ["user_id"], name: "index_outlines_on_user_id", using: :btree

  create_table "roles", force: :cascade do |t|
    t.integer  "role_type",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "rules", force: :cascade do |t|
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "immutable",  default: false
    t.boolean  "required",   default: false
  end

  create_table "senate_rules", force: :cascade do |t|
    t.integer  "faculty_id",  limit: 4
    t.integer  "element_id",  limit: 4
    t.string   "name",        limit: 255
    t.string   "description", limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "tools", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "faculty_id", limit: 4
    t.integer  "element_id", limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "tools", ["element_id"], name: "index_tools_on_element_id", using: :btree
  add_index "tools", ["faculty_id"], name: "index_tools_on_faculty_id", using: :btree

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "role_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "user_roles", ["role_id"], name: "index_user_roles_on_role_id", using: :btree
  add_index "user_roles", ["user_id"], name: "index_user_roles_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "tools", "elements"
  add_foreign_key "tools", "faculties"
end
