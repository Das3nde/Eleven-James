class FixFedexIdType < ActiveRecord::Migration
  def up
    change_column :fedex_transits, :id, :string
  end

  def down
  end
end
