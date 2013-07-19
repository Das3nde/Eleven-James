class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.decimal :amount
      t.string :purpose
      t.string :status
      t.string :cc_last_four
      t.string :txn_id
      t.text :custom_message
      t.text :paypal_response_dump
      t.string :ipn_status
      t.text :ipn_custom_message
      t.text :ipn_response_dump
      t.timestamps
    end
  end
end
