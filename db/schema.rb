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

ActiveRecord::Schema.define(version: 20131115034819) do

  create_table "activity_logs", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.string   "action"
    t.string   "serialized_object"
    t.datetime "occurred_at"
  end

  add_index "activity_logs", ["item_id", "item_type"], name: "index_activity_logs_on_item_id_and_item_type", using: :btree
  add_index "activity_logs", ["user_id"], name: "index_activity_logs_on_user_id", using: :btree

  create_table "attachments", force: true do |t|
    t.string   "document_file_name"
    t.string   "document_content_type"
    t.integer  "document_file_size"
    t.datetime "document_updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "deleted_at"
  end

  create_table "crowds", force: true do |t|
    t.string   "name"
    t.integer  "semester"
    t.integer  "year"
    t.string   "code"
    t.integer  "professor_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "crowds", ["professor_id"], name: "index_crowds_on_professor_id", using: :btree
  add_index "crowds", ["subject_id"], name: "index_crowds_on_subject_id", using: :btree

  create_table "enrollments", force: true do |t|
    t.integer  "student_id"
    t.integer  "crowd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "enrollments", ["crowd_id"], name: "enrollments_crowd_id_fk", using: :btree
  add_index "enrollments", ["student_id"], name: "enrollments_student_id_fk", using: :btree

  create_table "enunciations", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "end_at"
    t.integer  "crowd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.boolean  "accepts_after_deadline", default: false
  end

  add_index "enunciations", ["crowd_id"], name: "index_enunciations_on_crowd_id", using: :btree

  create_table "groups", force: true do |t|
    t.string   "name"
    t.integer  "enunciation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "groups", ["enunciation_id"], name: "index_groups_on_enunciation_id", using: :btree

  create_table "gtasks", force: true do |t|
    t.integer  "user_id"
    t.integer  "task_id"
    t.string   "gevent_id"
    t.datetime "deleted_at"
  end

  add_index "gtasks", ["task_id"], name: "index_gtasks_on_task_id", using: :btree
  add_index "gtasks", ["user_id"], name: "index_gtasks_on_user_id", using: :btree

  create_table "memberships", force: true do |t|
    t.integer  "student_id"
    t.integer  "group_id"
    t.datetime "deleted_at"
  end

  add_index "memberships", ["group_id"], name: "index_memberships_on_group_id", using: :btree
  add_index "memberships", ["student_id"], name: "index_memberships_on_student_id", using: :btree

  create_table "messages_deliveries", force: true do |t|
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.boolean  "readed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "messages_deliveries", ["message_id"], name: "index_messages_deliveries_on_message_id", using: :btree
  add_index "messages_deliveries", ["recipient_id"], name: "index_messages_deliveries_on_recipient_id", using: :btree

  create_table "messages_messages", force: true do |t|
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "messages_messages", ["sender_id"], name: "index_messages_messages_on_sender_id", using: :btree
  add_index "messages_messages", ["topic_id"], name: "index_messages_messages_on_topic_id", using: :btree

  create_table "messages_topics", force: true do |t|
    t.integer  "circle_id"
    t.string   "circle_type"
    t.integer  "creator_id"
    t.string   "creator_type"
    t.string   "subject"
    t.boolean  "approved",          default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "include_professor", default: true
    t.boolean  "reproved",          default: false
    t.datetime "deleted_at"
  end

  add_index "messages_topics", ["circle_id", "circle_type"], name: "index_messages_topics_on_circle_id_and_circle_type", using: :btree
  add_index "messages_topics", ["creator_id", "creator_type"], name: "index_messages_topics_on_creator_id_and_creator_type", using: :btree

  create_table "pub_keys", force: true do |t|
    t.string  "name"
    t.text    "value"
    t.integer "user_id"
  end

  add_index "pub_keys", ["user_id"], name: "pub_keys_user_id_fk", using: :btree

  create_table "repo_versions", force: true do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
    t.datetime "deleted_at"
  end

  add_index "repo_versions", ["creator_id"], name: "index_repo_versions_on_creator_id", using: :btree
  add_index "repo_versions", ["group_id"], name: "index_repo_versions_on_group_id", using: :btree

  create_table "repositories", force: true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "repositories", ["group_id"], name: "repositories_group_id_fk", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.date     "scheduled_start_date"
    t.date     "scheduled_end_date"
    t.integer  "group_id"
    t.string   "description"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "tasks", ["group_id"], name: "index_tasks_on_group_id", using: :btree
  add_index "tasks", ["parent_id"], name: "index_tasks_on_parent_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "type"
    t.string   "oauth_refresh_token"
    t.string   "oauth_access_token"
    t.integer  "oauth_expires_in"
    t.string   "gcalendar_id"
    t.string   "password_reset_token"
  end

  add_foreign_key "activity_logs", "users", name: "activity_logs_user_id_fk"

  add_foreign_key "enrollments", "crowds", name: "enrollments_crowd_id_fk"
  add_foreign_key "enrollments", "users", name: "enrollments_student_id_fk", column: "student_id"

  add_foreign_key "enunciations", "crowds", name: "enunciations_crowd_id_fk"

  add_foreign_key "groups", "enunciations", name: "groups_enunciation_id_fk"

  add_foreign_key "gtasks", "tasks", name: "gtasks_task_id_fk"
  add_foreign_key "gtasks", "users", name: "gtasks_user_id_fk"

  add_foreign_key "memberships", "groups", name: "memberships_group_id_fk", dependent: :delete
  add_foreign_key "memberships", "users", name: "memberships_student_id_fk", column: "student_id", dependent: :delete

  add_foreign_key "messages_deliveries", "messages_messages", name: "messages_deliveries_message_id_fk", column: "message_id"
  add_foreign_key "messages_deliveries", "users", name: "messages_deliveries_recipient_id_fk", column: "recipient_id"

  add_foreign_key "messages_messages", "messages_topics", name: "messages_messages_topic_id_fk", column: "topic_id"
  add_foreign_key "messages_messages", "users", name: "messages_messages_sender_id_fk", column: "sender_id"

  add_foreign_key "pub_keys", "users", name: "pub_keys_user_id_fk"

  add_foreign_key "repo_versions", "groups", name: "repo_versions_group_id_fk"
  add_foreign_key "repo_versions", "users", name: "repo_versions_creator_id_fk", column: "creator_id"

  add_foreign_key "repositories", "groups", name: "repositories_group_id_fk"

  add_foreign_key "tasks", "groups", name: "tasks_group_id_fk"
  add_foreign_key "tasks", "tasks", name: "tasks_parent_id_fk", column: "parent_id"

end
