
module CsvImport
  require 'csv'
  def self.import_csv(path)
    header_map =  {
        'Family'=> 'model',
        'Brand' =>'brand',
        'Band Material' =>'material',
        'Bucketed Classification' => 'style',
        'Face Color' => 'color',
        'Case Diameter' =>'case_size',
        'Face Color' => 'face',
        'Collection'=>'tier'
    }
    file = File.open(path).read
    spreadsheet = CSV.parse(file)
    header = spreadsheet[0]
    puts header
    (2..(spreadsheet.count-1)).each do |i|
      attrs = {}
      image = nil
      spreadsheet[i].each_with_index do |cell, j|
        attr = header_map[header[j]]
        if(attr)
          attrs[attr] = cell
        end
        if header[j] == 'Image' && cell
          puts 'sdzsd'
          image = File.new('/tmp/'+cell, "r")
        end
      end
      if(image)
        product = Product.new(attrs)
        product_image = ProductImage.new(:image => image)
        product.product_images << product_image
        product.save
        product_image.save
      end

    end
  end
end