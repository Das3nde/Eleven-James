class HomeController < ApplicationController

  layout :determine_layout

  def index
    @users = User.all
  end

  def collection
    @wrapper = "listing"
    @products = Product.where("quantity > ?", 0)
    @requested_product_ids = ProductRequest.where("user_id = ?", current_user.id).collect(&:product_id)
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
    @wrapper = "queue"
    @requested_products = ProductRequest.where("fulfillment_time IS NULL AND user_id = ?", current_user.id)
  end

  private

  def determine_layout
    case action_name
    when 'collection', 'user_queue'
      'app'
    else
      'application'
    end
  end

end
