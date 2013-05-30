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

ActiveRecord::Schema.define(:version => 20130530041142) do

  create_table "admins", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "admins", ["name", "resource_type", "resource_id"], :name => "index_admins_on_name_and_resource_type_and_resource_id"
  add_index "admins", ["name"], :name => "index_admins_on_name"

  create_table "courier_transits", :force => true, :id => false do |t|
    t.string   "id"
    t.string   "courier"
    t.boolean  "is_signature_required"
    t.string   "customer"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end

  execute "ALTER TABLE courier_transits ADD PRIMARY KEY (id);"

  create_table "customers", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "customers", ["name", "resource_type", "resource_id"], :name => "index_customers_on_name_and_resource_type_and_resource_id"
  add_index "customers", ["name"], :name => "index_customers_on_name"

  create_table "event_transits", :force => true, :id => false do |t|
    t.string   "id"
    t.integer  "event_id"
    t.boolean  "is_pickup"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  execute "ALTER TABLE event_transits ADD PRIMARY KEY (id);"
  add_index "event_transits", ["event_id"], :name => "index_event_transits_on_event_id"

  create_table "events", :force => true, :id => false do |t|
    t.string   "id"
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
    t.datetime     "start_time"
    t.datetime     "end_time"
    t.date     "date"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  execute "ALTER TABLE events ADD PRIMARY KEY (id);"

  create_table "fedex_transits", :force => true, :id=> false do |t|
    t.string   "id"
    t.string   "shipping_class"
    t.string   "tracking_number"
    t.boolean  "is_signature_required"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
  end
  execute "ALTER TABLE fedex_transits ADD PRIMARY KEY (id);"

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

  create_table "product_instances", :id => false, :force => true do |t|
    t.string  "id"
    t.integer  "model_id"
    t.string  "record_id"
    t.string   "current_size"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "required_size"
    t.boolean  "is_available"
    t.boolean  "is_clean"
  end

  execute "ALTER TABLE product_instances ADD PRIMARY KEY (id);"

  create_table "rotations", :force => true , :id => false do |t|
    t.string   "id"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  execute "ALTER TABLE rotations ADD PRIMARY KEY (id);"

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
    t.integer  "price"
    t.boolean  "is_featured"
    t.boolean  "is_new"
    t.integer  "vendor_id"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "quantity"
  end

  add_index "products", ["tier_id"], :name => "index_products_on_tier_id"
  add_index "products", ["vendor_id"], :name => "index_products_on_vendor_id"

  create_table "records", :force => true, :id => false do |t|
    t.string   "id"
    t.string   "product_instance_id"
    t.string   "table"
    t.datetime     "start_time"
    t.datetime     "due_time"
    t.datetime     "end_time"
    t.string   "bin_number"
    t.string   "int"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.datetime     "est_start_time"
    t.datetime     "est_end_time"
    t.string   "prev_record_id"
    t.string   "next_record_id"
  end

  add_index "records", ["product_instance_id"], :name => "index_records_on_product_instance_id"
  execute "ALTER TABLE records ADD PRIMARY KEY (id);"

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "services", :force => true, :id=>false do |t|
    t.string   "id"
    t.string   "requested_size"
    t.boolean  "cleaning"
    t.text     "repair_description"
    t.integer  "vendor_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "services", ["vendor_id"], :name => "index_services_on_vendor_id"
  execute "ALTER TABLE services ADD PRIMARY KEY (id);"

  create_table "storage_records", :force => true, :id => false do |t|
    t.string   "id"
    t.integer  "bin_number"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  execute "ALTER TABLE storage_records ADD PRIMARY KEY (id);"

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
