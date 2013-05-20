class CreateEventTransits < ActiveRecord::Migration
  def change
    create_table :event_transits do |t|
      t.references :event
      t.boolean :is_pickup

      t.timestamps
    end
    add_index :event_transits, :event_id
  end
end
