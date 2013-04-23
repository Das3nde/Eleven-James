class StaticPagesController < ApplicationController
  layout "static"
  
  def splash
    @wrapper = "splash"
  end

  def account
    @wrapper = "account"
  end

  def concierge
    @wrapper = "concierge"
  end

  def contact_us
    @wrapper = "contact"
  end

  def detail
    @wrapper = "detail"
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
