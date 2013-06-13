class AddTransitClassToUser < ActiveRecord::Migration
  def change
    add_column :users, :transit_table, :string
  end
end
