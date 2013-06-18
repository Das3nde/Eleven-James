class ChangeProductCaseSizeType < ActiveRecord::Migration
  def up
    change_column :products, :case_size, :int, :using
  end

  def down
  end
end
