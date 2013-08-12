class Product < ActiveRecord::Base
  @@fields = {
      model: {},
      collection: {as: 'select', selection_coords: true},
      brand: {as: 'select', algorithm:true},
      case_diameter: {algorithm:true},
      face_color: {as:'select', input_html:{multiple:true}, algorithm:true },
      case_material: {as:'select', input_html:{multiple:true}, algorithm:true },
      band_color: {as: 'select', algorithm:true},
      band_material: {as: 'select', algorithm:true},
      band_name: {as: 'select', algorithm:true},
      reference: {},
      family: {},
      cost: {as: 'currency'},
      retail_price: {as: 'currency'},
      dial_style: {as: 'select', input_html:{multiple:true}},
      hand_color: {as: 'select', input_html:{multiple:true}},
      clasp_type: {as: 'select'},
      movement: {as: 'select'},
      power_reserve: {},
      bezel_type: {as: 'select'},
      purchase_date: {as:'dateselect'},
      vendor_id: {as: 'collection_select'},
      bucketed_classification: {as: 'select', input_html:{multiple:true}},
      water_resistance: {},
      is_used:  {},
      is_new_arrival: {},
      is_featured: {},
      is_borrowed: {},
      banner_display: {},
      return_date: {as:'dateselect'},
      description: {as: 'text'}

  }
  before_save :convert_fields
  belongs_to :vendor
  has_many :product_images, :dependent => :destroy
  has_many :product_instances, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  accepts_nested_attributes_for :product_images, :reject_if => lambda { |t| t['product_images'].nil? }
  accepts_nested_attributes_for :product_instances

  attr_accessible *@@fields.keys

  has_attached_file :banner_image, :styles => { :banner => '750x530#' }

  def convert_fields
    Product.fields.each do |attr,meta|
      val = self[attr]
      if(attr.to_s.index('is_')==0 && val.is_a?(String))
        self[attr] = val.downcase == 'true' ? true : false;
      elsif(meta[:as] == 'dateselect' && val.is_a?(String))
        self[attr] = Chronic.parse(val)
      elsif(meta[:as] == 'currency' && val.is_a?(String))
        self[attr] = Money.parse(val).to_f
      end
    end
  end

  def self.fields
    @@fields
  end

  def add_inventory
    product_id = sprintf '%05d', id
    quantity = ProductInstance.where('id ~ ?','^'+product_id).count + 1

    instance = ProductInstance.create(
        :id => "#{product_id}-#{quantity}",
        :is_available => true
    )
    product_instances << instance
    self.quantity = self.product_instances.size
    save()
    instance
  end

  def self.algorithm_fields
    Product.fields.reject{|k,v| !v[:algorithm]}.keys
  end

  def to_vector
    #need to implement support for fields with multiple values in them,
    vector = {}
    Product.algorithm_fields.each do |attr|
      val = self[attr]
      if(val && !val.to_s.empty?)
        vector[attr.to_s+'-'+val.to_s] = 1;
      end
    end
    vector['case_diameter'] = relative_case_diameter()
    return vector
  end

  def relative_case_diameter
    @@max_case_diameter ||= Product.maximum('case_diameter').to_i;
    @@min_case_diameter ||= Product.minimum('case_diameter').to_i;
    if @@max_case_diameter === @@min_case_diameter
      return 1
    end
    (case_diameter.to_i - @@min_case_diameter * 1.0) / (@@max_case_diameter - @@min_case_diameter)
  end

  def self.get_options field
    key = 'admin::product::options::'+ field.to_s
    stored = REDIS.get(key)
    if stored
      return JSON.parse(stored)
    else
      options = Product.select(field).group(field).map{ |p|
        self.multi_to_array(field, p)
      }.flatten.uniq
      options = options[0] == nil && options.size == 1 ? [] : options
      REDIS.set(key, options.to_json)
      return options
    end
  end

  def self.multi_to_array field, hash
    v = hash[field]
    field = field.to_sym
    (v.is_a?(String) && v.include?(',') && Product.fields[field] &&
        Product.fields[field.to_sym][:input_html] && Product.fields[field][:input_html][:multiple]) ?
        v.split(',') : v
  end

  def self.add_option field, option
    options = self.get_options(field)
    if(options.include?(option))
      return false
    end
    options << option
    REDIS.set('admin::product::options::'+ field.to_s, options.to_json)
  end

  def image(style= 'thumb')
    product_images.first && product_images.first.url(style)
  end

  def to_display
    self.attributes.keys.each do |k|
      self[k] = Product.multi_to_array(k, self)
    end
  end

  def self.show_as_banner
    where("banner_display = ?", true)
  end

  def self.newest_in_collection
    where("quantity > 0").order("created_at DESC").first
  end

  def default_image(type= :square)
    if product_images.length > 0
      product_images.first.url(type)
    else
      "/assets/temp/no_image.jpg"
    end
  end

end
