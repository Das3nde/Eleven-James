class ChangeProductCaseSizeType < ActiveRecord::Migration
  def up
    #change_column :products, :case_size, :int, :using
    Product.all.each do |p|
      p.case_size =  10 #change all to integer value
      p.save
    end
    ActiveRecord::Base.connection.execute("ALTER TABLE products ALTER COLUMN case_size TYPE integer USING (trim(case_size)::integer);")
  end

  def down
  end
end
