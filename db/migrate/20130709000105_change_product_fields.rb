class ChangeProductFields < ActiveRecord::Migration
  def change
    drop_table :products
    create_table :products do |t|
      t.string  'model'
      t.integer 'quantity'
      t.string  'collection'
      t.string  'brand'
      t.integer  'case_diameter'
      t.string  'face_color'
      t.string  'case_material'
      t.string  'band_color'
      t.string  'band_material'
      t.string  'band_name'
      t.string  'reference'
      t.string  'family'
      t.text    'description'
      t.integer 'cost'
      t.integer 'retail_price'
      t.string  'dial_style'
      t.string  'hand_color'
      t.string  'clasp_type'
      t.boolean 'is_used'
      t.string  'movement'
      t.string  'power_reserve'
      t.string  'bezel_type'
      t.date    'purchase_date'
      t.string  'vendor_id'
      t.string  'bucketed_classification'
      t.integer 'water_resistance'
      t.boolean 'is_borrowed'
      t.date    'return_date'
      t.boolean 'is_new_arrival'
      t.boolean 'is_featured'
    end
    add_column :product_images, :order, :integer
  end
end
