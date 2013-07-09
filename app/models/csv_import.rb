
module CsvImport
  require 'csv'
  def self.import_csv(path)
    file = File.open(path).read
    spreadsheet = CSV.parse(file)
    header = spreadsheet[0]
    (2..(spreadsheet.count-1)).each do |i|
      attrs = {}
      image = nil
      spreadsheet[i].each_with_index do |cell, j|
        attr = header[j].underscore.gsub(' ','_')
        meta = Product.fields[attr.to_sym]
        if(meta)
          attrs[attr] = cell
        end
        if header[j] == 'Image' && cell
          p = path.split('/')
          p.pop()
          dir = p.join('/')+'/'
          puts dir+cell
          image = File.new(dir+cell, "r")
        end
      end
      if(image)
        product = Product.new(attrs)
        product_image = ProductImage.new(:image => image)
        product.product_images << product_image
        product.save
        product.add_inventory
        product_image.save
      end

    end
    REDIS.flushall
  end
end