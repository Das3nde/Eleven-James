class AddPrevAndNextToRecords < ActiveRecord::Migration
  def change
    add_column :records, :prev_record, :string
    add_column :records, :next_record, :string
    remove_column :fedex_transits, :destination_record
    remove_column :fedex_transits, :origin_record
  end
end
