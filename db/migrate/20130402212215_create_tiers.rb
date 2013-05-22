class CreateTiers < ActiveRecord::Migration
  def change
    create_table :tiers do |t|
      t.string :name
      t.integer :cost

      t.timestamps
    end
  end
end
