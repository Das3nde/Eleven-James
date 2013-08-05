class AddFeaturedImageToProducts < ActiveRecord::Migration
  def change
    add_attachment :products, :featured_image
  end
end
