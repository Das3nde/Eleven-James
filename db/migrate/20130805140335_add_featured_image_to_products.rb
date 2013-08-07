class AddFeaturedImageToProducts < ActiveRecord::Migration
  def change
    add_attachment :products, :banner_image
  end
end
