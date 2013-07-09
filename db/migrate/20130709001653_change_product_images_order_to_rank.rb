class ChangeProductImagesOrderToRank < ActiveRecord::Migration
  def up
    rename_column :product_images, :order, :rank
  end

  def down
  end
end
