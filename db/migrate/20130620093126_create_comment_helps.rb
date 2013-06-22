class CreateCommentHelps < ActiveRecord::Migration
  def change
    create_table :comment_helps do |t|
      t.integer :comment_id
      t.integer :user_id
      t.boolean :helpful
      t.timestamps
    end
  end
end
