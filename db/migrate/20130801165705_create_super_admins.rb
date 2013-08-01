class CreateSuperAdmins < ActiveRecord::Migration
  def change
    create_table :super_admins do |t|
      t.string :email
      t.string :password_hash
      t.timestamps
    end
  end
end
