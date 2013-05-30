class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :first_name
      t.string :last_name
      t.text :address_line
      t.string :apt_unit
      t.string :city
      t.string :state
      t.string :zip
      t.string :phone
      t.string :type
      t.integer :addressable_id
      t.string :addressable_type
      t.timestamps
    end
  end
end
