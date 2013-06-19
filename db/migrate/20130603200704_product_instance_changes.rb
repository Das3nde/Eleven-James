class ProductInstanceChanges < ActiveRecord::Migration
  def up
    change_column :product_instances, :status_id, :string
    add_column :product_instances, :next_status_id, :string
    add_column :product_instances, :next_status_table, :string
    add_column :product_instances, :prev_status_id, :string
    add_column :product_instances, :prev_status_table, :string

    remove_column :records, :prev_record_id
    remove_column :records, :next_record_id
  end

  def down
  end
end
