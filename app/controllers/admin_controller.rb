class AdminController < ApplicationController

  before_filter :super_admin_required

  helper_method :show_tabs

  cattr_accessor :tabs
  before_filter :set_tabs

  before_filter lambda {request.xhr? ? self.class.layout(false) : self.class.layout('admin') }
  before_filter :set_cache_buster, :set_tabs

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end


  def show_tabs
    render('layouts/admin/_tabs', :layout=>false)[0]
  end

  def set_tabs
    @tabs = @@tabs
  end
end