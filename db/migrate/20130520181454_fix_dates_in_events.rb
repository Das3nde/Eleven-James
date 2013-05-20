class FixDatesInEvents < ActiveRecord::Migration
  def up
    add_column :events, :start_time, :time
    add_column :events, :end_time, :time
    add_column :events, :date, :date
  end

  def down
  end
end
