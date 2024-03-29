class Admin::ProductsController < AdminController
  #before_filter :user_preferences
  #authentication before filter is in admin controller

  @@tabs = {
      :index => 'All Products',
      :add_product => 'Add Model',
      :featured => 'Featured',
      :new_arrivals  => 'New Arrivals',
      :popular => 'Popular'
  }
  def index
    @product_image = ProductImage.new()
    @products = Product.order('id ASC')
    if request.xhr?
      render :file => 'admin/products/products'
    end
  end
  def user_preferences
    key = 'admin::'+ (current_user.id.to_s)
    stored = REDIS.get(key)
    @admin_prefs = stored ? JSON.parse(stored) :  {}
    if params[:sort]
      params[:sort] = params[:sort] == 'tier' ? 'tier_id' : params[:sort]
      @admin_prefs['product_sort'] = params[:sort] + " " + (params[:order] == '1' ? 'ASC': 'DESC')
    end
    if params['page_size']
      @admin_prefs['page_size'] = params['page_size']
    end
    if params[:prefs]
      REDIS.set(key, @admin_prefs.to_json)
    end
    @order = @admin_prefs['product_sort'] || "model"
    @page_size = @admin_prefs['page_size'].to_i || 10;
  end

  def add_option
    Product.add_option(params[:field], params[:option])
    render :nothing => true
  end

  def products
    @products = Product.order(@order).page(params[:page]).per(@page_size)
  end

  def featured
    @products = Product.where('is_featured = true')
    render :layout => false, :file => 'admin/products/_featured'
  end
  def new_arrivals
    render :nothing => true
  end
  def popular
    prq = ProductRequest.count(:all, :group => 'product_id')
    render :json => {:ok => prq.to_a}
  end
  def edit
    @product = Product.find(params[:id])
    model_id = sprintf '%05d', params[:id]
    @product_instances = ProductInstance.where('id ~ ?','^'+model_id)
    @product_image = ProductImage.new()
    render "admin/products/create_edit"
  end
  def add_product
    @product = Product.where('model = ?', 'Untitled Model').last || Product.create({:model => 'Untitled Model'})
    @product.product_instances
    @product.to_display()
    @product_image = ProductImage.new()
    render :layout => false, :file => "admin/products/_add_model"
  end
  def update
    product = Product.find(params[:id])
    attrs = params[:product]
    attrs.each do |k,v|
      v = v.kind_of?(Array) && v.shift ? v.join(',') : v    #for some reason chosen makes the first element of the array an empty string, hence the shift
      attrs[k] = k.to_s.include?('_date') ? Chronic.parse(v) : v
    end
    if product.update_attributes(attrs)
      render :json => {:ok => true}
    else
      render :json => {:ok => false}
    end
  end
  def add_inventory
    product = Product.find(params[:id])
    instance = product.add_inventory();

    render :json => {:id=> instance.id, :quantity => product.quantity}
  end
  def upload_image
    render :json => {:something => "changed now"}
  end
  def show
    @product = Product.find(params[:id])
    @product_instances = ProductInstance.where('id ~ ?','^'+ sprintf('%05d',@product.id))
    @product_image = ProductImage.new()
    @product.to_display()
    render :layout => false, :file => "admin/products/_add_model"
  end
  def reorder_images
    a = []
    params[:order].each_with_index do |id, i|
      ProductImage.find(id).update_attribute(:rank, i)
      a << ProductImage.find(id)
    end
    render json: a
  end

  def add_banner_photo
    @product = Product.find(params[:hidden_product_id])
    @product.banner_image = params[:banner_image]
    @product.save
    render :layout => false
  end

  private
    def set_tabs
      @tabs = {
          :index => 'All Products',
          :add_product => 'Add Model',
          :featured => 'Featured',
          :new_arrivals  => 'New Arrivals',
          :popular => 'Popular'
      }
    end
end

