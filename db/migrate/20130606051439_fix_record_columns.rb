class FixRecordColumns < ActiveRecord::Migration
  def up
    add_column :records, :next_id, :string
    add_column :records, :next_table, :string
    remove_column :records, :bin_number
    remove_column :records, :int

  end

  def down
  end
end
