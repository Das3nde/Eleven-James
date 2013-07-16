class HomeController < ApplicationController

  layout :determine_layout

  def index
    @users = User.all
  end

  def collection
    @wrapper = "listing"
    @products = Product.where("quantity > ?", 0)
    if current_user
      @requested_product_ids = ProductRequest.where("user_id = ?", current_user.id).collect(&:product_id)
    end
    @requested_product_ids ||= []
  end

  def filter_collection
    @products = Product.where("quantity > ?", 0)

    @products = @products.where("LOWER(brand) ilike ?", params[:brand].downcase.strip) if params[:brand].present?
    @products = @products.where("LOWER(tier) ilike ?", params[:tier].downcase.strip) if params[:tier].present?
    @products = @products.where("LOWER(style) ilike ?", params[:type].downcase.strip) if params[:type].present?
    @products = @products.where("LOWER(face) ilike ?", params[:face].downcase.strip) if params[:face].present?
    #@products.where("brand = ?", params[:brand]) if params[:width].present?

    @requested_product_ids = ProductRequest.where("user_id = ?", current_user.id).collect(&:product_id)
    render layout: false
  end

  def user_queue
    if not current_user
      redirect_to :controller => :home, :action => :collection
      return false
    end
    @wrapper = "queue"
    @requested_products = ProductRequest.where("fulfillment_time IS NULL AND user_id = ?", current_user.id)
  end

  def contact
    @wrapper = "contact"
  end

  def save_contact
    @contact = Contact.new(params[:contact])
    @status = @contact.save
    render layout: false
  end

  def service_benefits
    @wrapper = "concierge"
  end

  def home_index
    @wrapper = "home"
  end

  private

  def determine_layout
    case action_name
    when 'collection', 'user_queue', 'contact', 'service_benefits'
      'app'
    when 'home_index'
      'home'
    else
      'application'
    end
  end

end
