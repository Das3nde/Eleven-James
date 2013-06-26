class AdminController < ApplicationController
  before_filter :authenticate_user!
  helper_method :tabs
  before_filter lambda {request.xhr? ? self.class.layout(false) : self.class.layout('admin') }
  before_filter :set_cache_buster

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

  def tabs
    @tabs
  end
  def self.tabs
    @tabs
  end
end