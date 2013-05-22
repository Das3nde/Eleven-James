class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.string :id
      t.string :requested_size
      t.boolean :cleaning
      t.text :repair_description
      t.references :vendor

      t.timestamps
    end
    add_index :services, :vendor_id
  end
end
