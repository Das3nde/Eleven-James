class StaticPagesController < ApplicationController
  layout "static"
  
  def splash
    @wrapper = "splash"
  end

  def account
    @wrapper = "account"
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
