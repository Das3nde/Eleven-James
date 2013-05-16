class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.string :name
      t.string :address
      t.integer :phone
      t.integer :fax
      t.string :email
      t.string :website
      t.string :address
      t.string :city
      t.string :state
      t.string :postal_code

      t.timestamps
    end
  end
end
