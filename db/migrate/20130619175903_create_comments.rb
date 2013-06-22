class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :product_id
      t.integer :user_id
      t.text :description
      t.attachment :avatar
      t.integer :fit_score, default: 0
      t.integer :excitement_score, default: 0
      t.integer :accuracy_score, default: 0
      t.integer :wear_again_score, default: 0
      t.timestamps
    end
  end
end
