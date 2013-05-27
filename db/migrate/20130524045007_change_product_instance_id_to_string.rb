class ChangeProductInstanceIdToString < ActiveRecord::Migration
  def up
    change_column :product_instances, :id, :string
  end

  def down
  end
end
