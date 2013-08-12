class AddBannerDisplayToProducts < ActiveRecord::Migration
  def change
    add_column :products, :banner_display, :boolean, :default => false
  end
end
