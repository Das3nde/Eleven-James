class AddDraftModeAndRsvp < ActiveRecord::Migration
  def up
    add_column :events, :status, :string
    add_column :news, :status, :string
    add_column :events, :rsvp, :string, limit: 1000
  end

  def down
    remove_column :events, :status
    remove_column :news, :status
    remove_column :events, :rsvp
  end
end
