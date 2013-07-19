class AddPaypalAuthorizationTokenToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal_authorization_token, :string
    add_column :users, :approved, :boolean, default: false
    add_column :users, :paypal_profile_id, :string
    add_column :users, :payment_mode, :string
  end
end
