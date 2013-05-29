class CreateProductRequests < ActiveRecord::Migration
  def change
    create_table :product_requests do |t|
      t.references :user
      t.datetime :date
      t.references :product
      t.references :product_instance
      t.date :fulfillment_time
      t.date :removal_time

      t.timestamps
    end
    add_index :product_requests, :user_id
    add_index :product_requests, :product_id
    add_index :product_requests, :product_instance_id
  end
end
