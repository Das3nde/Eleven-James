class AdminController < ApplicationController
  before_filter :authenticate_user!
  def admin
    @users = User.all

  end
end