class AddStatusTableToProductInstance < ActiveRecord::Migration
  def change
    add_column :product_instances, :status_table, :string
  end
end
