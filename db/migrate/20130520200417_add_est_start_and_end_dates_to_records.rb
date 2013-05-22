class AddEstStartAndEndDatesToRecords < ActiveRecord::Migration
  def up
    add_column :records, :est_start_date, :time
    add_column :records, :est_end_date, :time
  end

  def down
  end
end
