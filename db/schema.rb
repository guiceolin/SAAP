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

ActiveRecord::Schema.define(version: 20130922153140) do

  create_table "crowds", force: true do |t|
    t.string   "name"
    t.integer  "semester"
    t.integer  "year"
    t.string   "code"
    t.integer  "professor_id"
    t.integer  "subject_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enrollments", force: true do |t|
    t.integer  "student_id"
    t.integer  "crowd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "enunciations", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.date     "end_at"
    t.integer  "crowd_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enunciations", ["crowd_id"], name: "index_enunciations_on_crowd_id", using: :btree

  create_table "messages_deliveries", force: true do |t|
    t.integer  "message_id"
    t.integer  "recipient_id"
    t.boolean  "readed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "messages_deliveries", ["message_id"], name: "index_messages_deliveries_on_message_id", using: :btree
  add_index "messages_deliveries", ["recipient_id"], name: "index_messages_deliveries_on_recipient_id", using: :btree

  create_table "messages_messages", force: true do |t|
    t.text     "body"
    t.integer  "sender_id"
    t.integer  "topic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
  end

  add_index "messages_topics", ["circle_id", "circle_type"], name: "index_messages_topics_on_circle_id_and_circle_type", using: :btree
  add_index "messages_topics", ["creator_id", "creator_type"], name: "index_messages_topics_on_creator_id_and_creator_type", using: :btree

  create_table "subjects", force: true do |t|
    t.string   "name"
    t.string   "code"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "type"
  end

end
