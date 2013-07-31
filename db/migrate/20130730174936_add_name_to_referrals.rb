class AddNameToReferrals < ActiveRecord::Migration
  def change
    add_column :referrals, :name, :string
  end
end
