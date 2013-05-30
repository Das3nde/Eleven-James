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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130530181344) do

  create_table "addresses", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address_line"
    t.string   "apt_unit"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "type"
    t.integer  "addressable_id"
    t.string   "addressable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "admins", ["name", "resource_type", "resource_id"], :name => "index_admins_on_name_and_resource_type_and_resource_id"
  add_index "admins", ["name"], :name => "index_admins_on_name"

  create_table "courier_transits", :force => true do |t|
    t.string   "courier"
    t.boolean  "is_signature_required"
    t.string   "customer"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "customers", ["name", "resource_type", "resource_id"], :name => "index_customers_on_name_and_resource_type_and_resource_id"
  add_index "customers", ["name"], :name => "index_customers_on_name"

  create_table "event_transits", :force => true do |t|
    t.integer  "event_id"
    t.boolean  "is_pickup"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "event_transits", ["event_id"], :name => "index_event_transits_on_event_id"

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "subhead"
    t.text     "description"
    t.string   "venue"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "pickup"
    t.boolean  "drop_off"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.time     "start_time"
    t.time     "end_time"
    t.date     "date"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "fedex_transits", :force => true do |t|
    t.string   "shipping_class"
    t.string   "tracking_number"
    t.boolean  "is_signature_required"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  create_table "product_images", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "product_images", ["product_id"], :name => "index_product_images_on_product_id"

  create_table "product_instances", :force => true do |t|
    t.integer  "model_id"
    t.integer  "status_id"
    t.string   "current_size"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "required_size"
    t.boolean  "is_available"
    t.boolean  "is_clean"
  end

  create_table "product_requests", :force => true do |t|
    t.integer  "user_id"
    t.datetime "date"
    t.integer  "product_id"
    t.integer  "product_instance_id"
    t.date     "fulfillment_time"
    t.date     "removal_time"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "product_requests", ["product_id"], :name => "index_product_requests_on_product_id"
  add_index "product_requests", ["product_instance_id"], :name => "index_product_requests_on_product_instance_id"
  add_index "product_requests", ["user_id"], :name => "index_product_requests_on_user_id"

  create_table "products", :force => true do |t|
    t.string   "model"
    t.string   "brand"
    t.integer  "tier_id"
    t.string   "material"
    t.string   "style"
    t.string   "color"
    t.string   "case"
    t.integer  "msrp"
    t.integer  "vendor_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "quantity"
    t.boolean  "is_featured"
    t.boolean  "is_new"
    t.integer  "price"
    t.string   "face"
  end

  add_index "products", ["tier_id"], :name => "index_products_on_tier_id"
  add_index "products", ["vendor_id"], :name => "index_products_on_vendor_id"

  create_table "records", :force => true do |t|
    t.string   "product_id"
    t.string   "table"
    t.time     "start_date"
    t.time     "due_date"
    t.time     "end_date"
    t.string   "bin_number"
    t.string   "int"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.time     "est_start_date"
    t.time     "est_end_date"
    t.string   "prev_record"
    t.string   "next_record"
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "rotations", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "rotations", ["user_id"], :name => "index_rotations_on_user_id"

  create_table "services", :force => true do |t|
    t.string   "requested_size"
    t.boolean  "cleaning"
    t.text     "repair_description"
    t.integer  "vendor_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "services", ["vendor_id"], :name => "index_services_on_vendor_id"

  create_table "storage_records", :force => true do |t|
    t.integer  "bin_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "is_available"
  end

  create_table "tiers", :force => true do |t|
    t.string   "name"
    t.integer  "cost"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_admins", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "admin_id"
  end

  add_index "users_admins", ["user_id", "admin_id"], :name => "index_users_admins_on_user_id_and_admin_id"

  create_table "users_customers", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "customer_id"
  end

  add_index "users_customers", ["user_id", "customer_id"], :name => "index_users_customers_on_user_id_and_customer_id"

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

  create_table "vendors", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "phone"
    t.integer  "fax"
    t.string   "email"
    t.string   "website"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

end
