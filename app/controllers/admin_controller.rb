class AdminController < ApplicationController
  before_filter :authenticate_user!
  helper_method :tabs
  before_filter lambda {request.xhr? ? self.class.layout(false) : self.class.layout('admin') }

  def tabs
    @tabs
  end
  def self.tabs
    @tabs
  end
end