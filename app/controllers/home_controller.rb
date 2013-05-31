class HomeController < ApplicationController

  layout :determine_layout

  def index
    @users = User.all
  end

  def collection
    @wrapper = "listing"
    @products = Product.where("is_featured = ?", true)
    @requested_product_ids = ProductRequest.where("user_id = ?", current_user.id).collect(&:product_id)
  end

  def queue
    @wrapper = "queue"
    @requested_products = ProductRequest.where("user_id = ?", current_user.id)
  end

  private

  def determine_layout
    case action_name
    when 'collection', 'queue'
      'app'
    else
      'application'
    end
  end

end
