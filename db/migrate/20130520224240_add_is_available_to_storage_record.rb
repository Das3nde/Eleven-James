class AddIsAvailableToStorageRecord < ActiveRecord::Migration
  def change
    add_column :storage_records, :is_available, :boolean
  end
end
