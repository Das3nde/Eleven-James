class ChangeProductCase < ActiveRecord::Migration
  def up
    rename_column :products, :case, :case_size
  end

  def down
  end
end
