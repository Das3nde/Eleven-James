class ChangeProductTierToString < ActiveRecord::Migration
  def up
    add_column :products, :tier, :string
    remove_column :products, :tier_id
  end

  def down
  end
end
