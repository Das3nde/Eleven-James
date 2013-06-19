class AdminController < ApplicationController
  before_filter :authenticate_user!
  layout 'admin'
  helper_method :tabs

  def tabs
    @tabs
  end
  def self.tabs
    @tabs
  end
end