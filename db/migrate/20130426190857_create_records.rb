class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :id
      t.string :product_id
      t.string :table
      t.time :start_date
      t.time :due_date
      t.time :end_date
      t.string :bin_number
      t.string :int

      t.timestamps
    end
  end
end
