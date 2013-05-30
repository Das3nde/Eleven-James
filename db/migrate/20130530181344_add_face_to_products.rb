class AddFaceToProducts < ActiveRecord::Migration
  def change
    add_column :products, :face, :string
  end
end
