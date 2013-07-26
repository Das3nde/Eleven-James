class AddPaidTillToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paid_till, :datetime
  end
end
