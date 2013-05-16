class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :model
      t.string :brand
      t.references :tier
      t.string :material
      t.string :style
      t.string :color
      t.string :case
      t.integer :msrp
      t.references :vendor
      t.text :description

      t.timestamps
    end
    add_index :products, :tier_id
    add_index :products, :vendor_id
  end
end
