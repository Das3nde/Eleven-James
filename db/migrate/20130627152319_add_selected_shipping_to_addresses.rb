class AddSelectedShippingToAddresses < ActiveRecord::Migration
  def change
    add_column :addresses, :selected_shipping, :boolean, default: false
  end
end
