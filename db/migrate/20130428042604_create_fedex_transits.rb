class CreateFedexTransits < ActiveRecord::Migration
  def change
    create_table :fedex_transits do |t|
      t.string :id
      t.string :class
      t.string :tracking_number
      t.boolean :is_signature_required

      t.timestamps
    end
  end
end
