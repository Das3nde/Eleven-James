class ChangeEventTransitId < ActiveRecord::Migration
  def up
    change_column :event_transits, :id, :string
  end

  def down
  end
end
