class CreateCourierTransits < ActiveRecord::Migration
  def change
    create_table :courier_transits do |t|
      t.string :id
      t.string :courier
      t.boolean :is_signature_required
      t.string :customer

      t.timestamps
    end
  end
end
