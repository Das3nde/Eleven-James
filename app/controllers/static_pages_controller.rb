class StaticPagesController < ApplicationController
  layout "static"
  
  def splash
    @wrapper = "splash"
    @header_layout = "splash"
    @footer_layout = "splash"
  end

  def account
  end

  def concierge
  end

  def contact_us
  end

  def detail
  end

  def home
  end

  def listing
  end

  def queue
  end

  def signup
  end
end
