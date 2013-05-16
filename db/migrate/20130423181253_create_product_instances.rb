class CreateProductInstances < ActiveRecord::Migration
  def change
    create_table :product_instances do |t|
      t.integer :model_id
      t.string :status
      t.integer :status_id
      t.string :current_size

      t.timestamps
    end
  end
end
