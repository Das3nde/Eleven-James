class AddFieldsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :is_featured, :boolean
    add_column :products, :is_new, :boolean
    add_column :products, :price, :integer
  end
end
