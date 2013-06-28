class AddRentalMonthsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :rental_months, :string
  end
end
