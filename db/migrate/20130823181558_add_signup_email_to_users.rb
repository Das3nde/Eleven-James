class AddSignupEmailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :signup_email, :string
  end
end
