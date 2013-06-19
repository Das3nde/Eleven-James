class NewMigration < ActiveRecord::Migration
  def up
    add_column :rotations, :product_instance_id, :int
    add_column :fedex_transits, :product_instance_id, :int
    add_column :courier_transits, :product_instance_id, :int
    add_column :event_transits, :product_instance_id, :int
    add_column :storage_records, :product_instance_id, :int
    add_column :services, :product_instance_id, :int

    remove_column :records, :start_date
    remove_column :records, :end_date
    remove_column :records, :due_date
    remove_column :records, :est_start_date
    remove_column :records, :est_end_date

    add_column :records, :start_date, :datetime, :force => true
    add_column :records, :end_date, :datetime, :force => true
    add_column :records, :due_date, :datetime, :force => true
    add_column :records, :est_start_date, :datetime, :force => true
    add_column :records, :est_end_date, :datetime, :force => true
  end

  def down
  end
end
