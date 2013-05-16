class Admin::ProductsController < ApplicationController
  before_filter :user_preferences
  def user_preferences
    key = 'admin::'+ (current_user.id.to_s)
    stored = REDIS.get(key)
    @admin_prefs = stored ? JSON.parse(stored) :  {}
    if params[:sort]
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
  end
  def edit
    @product = Product.find(params[:id])
    model_id = sprintf '%05d', params[:id]
    @product_instances = ProductInstance.where('id ~ ?','^'+model_id)
    render "admin/products/create_edit"
  end
  def new
    @product = Product.new()
    @product_instances = []
    render "admin/products/create_edit"
  end
  def create
    product = Product.new(params[:product])
    product.save()
    redirect_to admin_products_path
  end
  def update
    product = Product.find(params[:id])
    if product.update_attributes params[:product]
      redirect_to admin_products_path
    else
      render :action => :edit
    end
  end
  def add_watch
    instance = ProductInstance.new
    model_id = sprintf '%05d', params[:id]
    product_id = ProductInstance.where('id ~ ?','^'+model_id).count + 1
    instance.id = "#{model_id}-#{product_id}"
    instance.save
    render :json => {:id=> instance.id}
  end
end

