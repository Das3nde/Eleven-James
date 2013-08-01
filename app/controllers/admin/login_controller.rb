class Admin::LoginController < ApplicationController

  skip_before_filter :super_admin_required

  def index

  end

  def signin
    @super_admin = SuperAdmin.find_by_email_and_password_hash(params[:admin_email], SuperAdmin.encrypted_password(params[:admin_password]))
    if @super_admin
      set_super_admin_session(@super_admin)
      redirect_to '/admin/products/'
      return
    else
      redirect_to '/admin/login', notice: 'Autentication Failed'
      return
    end
  end

end
