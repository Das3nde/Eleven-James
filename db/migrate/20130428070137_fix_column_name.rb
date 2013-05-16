class FixColumnName < ActiveRecord::Migration
  def self.up
    rename_column :fedex_transits, :class, :shipping_class
  end

  def self.down
    # rename back if you need or do something else or do nothing
  end
end

