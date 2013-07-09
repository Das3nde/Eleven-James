class CreateUnarrangedTransits < ActiveRecord::Migration
  def change
    create_table :unarranged_transits, :id => false do |t|
      t.string :uuid
      t.string :product_instance_id
      t.timestamps
    end
    execute "ALTER TABLE unarranged_transits ADD PRIMARY KEY (uuid);"
  end
end
