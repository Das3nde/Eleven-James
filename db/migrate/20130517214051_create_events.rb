class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :subhead
      t.text :description
      t.string :venue
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.boolean :pickup
      t.boolean :drop_off

      t.timestamps
    end
  end
end
