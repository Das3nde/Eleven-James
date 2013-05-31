class Admin::ProductsController < AdminController
  before_filter :user_preferences

  def models
    @product_image = ProductImage.new()
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

  def index
    @products = Product.order(@order).page(params[:page]).per(@page_size)
    render :layout => false
  end

  def featured
    @products = Product.where('is_featured = true')
    render :layout => false, :file => 'admin/products/_featured'
  end
  def new_arrivals
    render :nothing => true
  end
  def popular
    render :nothing => true
  end
  def edit
    @product = Product.find(params[:id])
    model_id = sprintf '%05d', params[:id]
    @product_instances = ProductInstance.where('id ~ ?','^'+model_id)
    @product_image = ProductImage.new()
    render "admin/products/create_edit"
  end
  def new
    @product = Product.where('model = ?', 'Untitled Model').last || Product.create({:model => 'Untitled Model'})
    @product_instances = ProductInstance.where('id ~ ?','^'+ sprintf('%05d',@product.id))
    @product_image = ProductImage.new()
    render :layout => false, :file => "admin/products/_add_model"
  end
  def update
    product = Product.find(params[:id])
    if product.update_attributes params[:product]
      render :json => {:ok => true}
    else
      render :json => {:ok => false}
    end
  end
  def add_inventory
    instance = ProductInstance.new
    model_id = sprintf '%05d', params[:id]
    product_id = ProductInstance.where('id ~ ?','^'+model_id).count + 1
    instance.id = "#{model_id}-#{product_id}"
    instance.save
    render :json => {:id=> instance.id}
  end
  def upload_image
    render :json => {:something => "changed now"}
  end
  def show
    @product = Product.find(params[:id])
    @product_instances = ProductInstance.where('id ~ ?','^'+ sprintf('%05d',@product.id))
    @product_image = ProductImage.new()
    render :layout => false, :file => "admin/products/_add_model"
  end
end

