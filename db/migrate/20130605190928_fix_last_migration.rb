class FixLastMigration < ActiveRecord::Migration
  def up
    change_column :rotations, :product_instance_id, :string
    change_column :fedex_transits, :product_instance_id, :string
    change_column :courier_transits, :product_instance_id, :string
    change_column :event_transits, :product_instance_id, :string
    change_column :storage_records, :product_instance_id, :string
    change_column :services, :product_instance_id, :string
  end

  def down
  end
end
