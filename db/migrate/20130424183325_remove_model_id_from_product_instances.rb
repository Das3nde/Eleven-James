class RemoveModelIdFromProductInstances < ActiveRecord::Migration
  def up
    remove_column :product_instances, :model_id
  end

  def down
    add_column :product_instances, :model_id, :integer
  end
  def change
    change_column :product_instances, :id, :string
  end
end
