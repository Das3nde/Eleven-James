class RenamePrevAndNextToRecords < ActiveRecord::Migration
  class AddPrevAndNextToRecords < ActiveRecord::Migration
    def change
      rename_column :records, :prev_record, :prev_record_id
      rename_column :records, :next_record, :next_record_id
    end
  end

end
