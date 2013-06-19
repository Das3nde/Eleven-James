class ChangeRecordsPrimaryKeyToUuid < ActiveRecord::Migration
  def up
    drop_table :product_instances
    drop_table :records
    drop_table :rotations
    drop_table :services
    drop_table :storage_records
    drop_table :courier_transits
    drop_table :event_transits
    drop_table :fedex_transits


    create_table "product_instances", {:id => false, :force => true} do |t|
      t.string   "id"
      t.integer  "product_id"
      t.integer  "status_id"
      t.string   "current_size"
      t.datetime "created_at",    :null => false
      t.datetime "updated_at",    :null => false
      t.string   "required_size"
      t.boolean  "is_available"
      t.boolean  "is_clean"
    end
    add_index "product_instances", ["product_id"], :name => "index_product_instances_on_product_id"
    execute "ALTER TABLE product_instances ADD PRIMARY KEY (id);"

    create_table "records",{:id => false, :force => true} do |t|
      t.string   "uuid"
      t.string   "product_instance_id"
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
      t.string   "prev_record_id"
      t.string   "next_record_id"
    end
    add_index "records", ["product_instance_id"], :name => "index_records_on_product_instance_id"
    execute "ALTER TABLE records ADD PRIMARY KEY (uuid);"

    create_table "rotations",{:id => false, :force => true} do |t|
      t.string   "uuid"
      t.integer  "user_id"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
    add_index "rotations", ["user_id"], :name => "index_rotations_on_user_id"
    execute "ALTER TABLE rotations ADD PRIMARY KEY (uuid);"

    create_table "services",{:id => false, :force => true} do |t|
      t.string   "uuid"
      t.string   "requested_size"
      t.boolean  "cleaning"
      t.text     "repair_description"
      t.integer  "vendor_id"
      t.datetime "created_at",         :null => false
      t.datetime "updated_at",         :null => false
    end

    add_index "services", ["vendor_id"], :name => "index_services_on_vendor_id"
    execute "ALTER TABLE services ADD PRIMARY KEY (uuid);"

    create_table "storage_records",{:id => false, :force => true} do |t|
      t.string   "uuid"
      t.integer  "bin_number"
      t.datetime "created_at",   :null => false
      t.datetime "updated_at",   :null => false
      t.boolean  "is_available"
    end
    execute "ALTER TABLE storage_records ADD PRIMARY KEY (uuid);"

    create_table "courier_transits",{:id => false, :force => true} do |t|
      t.string   "uuid"
      t.integer   "courier_id"
      t.boolean  "is_signature_required"
      t.string   "customer"
      t.datetime "created_at",            :null => false
      t.datetime "updated_at",            :null => false
    end
    add_index "courier_transits", ["courier_id"], :name => "index_courier_transits_courier_id"
    execute "ALTER TABLE courier_transits ADD PRIMARY KEY (uuid);"

    create_table "event_transits",{:id => false, :force => true} do |t|
      t.string   "uuid"
      t.integer  "event_id"
      t.boolean  "is_pickup"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end

    add_index "event_transits", ["event_id"], :name => "index_event_transits_on_event_id"
    execute "ALTER TABLE event_transits ADD PRIMARY KEY (uuid);"

    create_table "fedex_transits", {:id => false, :force => true} do |t|
      t.string   "uuid"
      t.string   "shipping_class"
      t.string   "tracking_number"
      t.boolean  "is_signature_required"
      t.datetime "created_at",            :null => false
      t.datetime "updated_at",            :null => false
    end

    add_index "fedex_transits", ["tracking_number"], :name => "index_fedex_transits_on_tracking_number"
    execute "ALTER TABLE fedex_transits ADD PRIMARY KEY (uuid);"

  end

  def down
  end
end
