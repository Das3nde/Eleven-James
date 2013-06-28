class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.text :pairings
      t.datetime :date

      t.timestamps
    end
  end
end
