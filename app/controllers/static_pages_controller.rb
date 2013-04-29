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
    @wrapper = "home"
  end

  def listing
    @wrapper = "listing"
  end

  def queue
    @wrapper = "queue"
  end

  def signup
    @wrapper = "signup"
  end
end
