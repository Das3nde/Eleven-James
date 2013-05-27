class AlterProductInstanceSchema < ActiveRecord::Migration
  def up
    add_column :product_instances, :required_size, :string
    add_column :product_instances, :is_available, :boolean
    add_column :product_instances, :is_clean, :boolean
    remove_column :product_instances, :status
  end

  def down

  end
end
