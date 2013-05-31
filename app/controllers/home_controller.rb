class HomeController < ApplicationController

  layout :determine_layout

  def index
    @users = User.all
  end

  def collection
    @wrapper = "listing"
    @products = Product.all
  end

  private

  def determine_layout
    case action_name
    when 'collection'
      'app'
    else
      'application'
    end
  end

end
