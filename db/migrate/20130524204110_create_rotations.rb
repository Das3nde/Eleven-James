class CreateRotations < ActiveRecord::Migration
  def change
    create_table :rotations do |t|
      t.string :id
      t.references :user

      t.timestamps
    end
    add_index :rotations, :user_id
  end
end
