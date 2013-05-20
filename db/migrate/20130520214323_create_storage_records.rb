class CreateStorageRecords < ActiveRecord::Migration
  def change
    create_table :storage_records do |t|
      t.string :id
      t.integer :bin_number

      t.timestamps
    end
  end
end
