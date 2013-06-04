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
