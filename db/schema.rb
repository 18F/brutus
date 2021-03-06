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

ActiveRecord::Schema.define(version: 20140505231425) do

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "agencies", force: true do |t|
    t.string   "name"
    t.string   "email_suffix"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "applications", force: true do |t|
    t.string   "remote_key"
    t.string   "remote_source"
    t.string   "status"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "flagged"
    t.text     "vet_status"
    t.boolean  "junk",          default: false
    t.text     "salesforce_id"
  end

  add_index "applications", ["remote_key"], name: "index_applications_on_remote_key"
  add_index "applications", ["remote_source"], name: "index_applications_on_remote_source"
  add_index "applications", ["salesforce_id"], name: "index_applications_on_salesforce_id"
  add_index "applications", ["status"], name: "index_applications_on_status"
  add_index "applications", ["vet_status"], name: "index_applications_on_vet_status"

  create_table "crediting_plan_assertions", force: true do |t|
    t.integer  "score"
    t.text     "description"
    t.integer  "crediting_plan_category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crediting_plan_assertions", ["crediting_plan_category_id"], name: "index_crediting_plan_assertions_on_crediting_plan_category_id"

  create_table "crediting_plan_categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "crediting_plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "crediting_plan_categories", ["crediting_plan_id"], name: "index_crediting_plan_categories_on_crediting_plan_id"

  create_table "crediting_plans", force: true do |t|
    t.string   "name"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "imports", force: true do |t|
    t.integer  "imports"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remote_source"
  end

  create_table "reviews", force: true do |t|
    t.integer  "user_id"
    t.integer  "score"
    t.text     "remarks"
    t.boolean  "follow_up"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "application_id"
  end

  add_index "reviews", ["follow_up"], name: "index_reviews_on_follow_up"
  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id"

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "second_factors", force: true do |t|
    t.string   "encrypted_password"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "token"
    t.integer  "agency_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
