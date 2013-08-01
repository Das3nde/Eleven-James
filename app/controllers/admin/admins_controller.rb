class Admin::AdminsController < AdminController

  #authentication before filter is in admin controller

  def index
    @admins = User.with_role :admin

  end
  def create
    pass = SecureRandom.hex(8)

    u = User.where('email = ?',params[:user][:email].downcase).last || User.new({:password=>pass})

    if !u.update_attributes(params[:user])
      return render :status => 404, :json => {:errors => u.errors}
    end
    u.add_role :admin
    render :json => u
  end
  def add_role
    User.find(params[:id]).add_role params[:role]
    render :nothing => true
  end
  def remove_role
    User.find(params[:id]).remove_role params[:role]
    render :nothing => true
  end
end