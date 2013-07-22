class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:sign_in]
  layout :determine_layout
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    authorize! :update, @user, :message => 'Not authorized as an administrator.'
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user], :as => :admin)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    authorize! :destroy, @user, :message => 'Not authorized as an administrator.'
    user = User.find(params[:id])
    unless user == current_user
      user.destroy
      redirect_to users_path, :notice => "User deleted."
    else
      redirect_to users_path, :notice => "Can't delete yourself."
    end
  end

  def request_product
    if current_user.approved
      pr = ProductRequest.new
      pr.user_id = current_user.id
      pr.product_id = Product.find(params[:product_id]).id
      pr.save
      status = 'success'
      message = ''
    else
      status = 'failed'
      message = 'You can add to queue once your account is approved'
    end
    render json: { status: status, message: message }
  end

  def delete_request
    pr = ProductRequest.where("id = ? AND user_id = ?", params[:request_id], current_user.id).first
    pr.destroy if pr
    render json: { status: 'success' }
  end

  def my_account
    @wrapper = "account"
    @user = User.find(current_user.id)
  end

  def update_account
    @user = User.find(current_user.id)
    if params[:user][:password].blank? && params[:user][:password_confirmation].blank?
      params[:user].delete("password")
      params[:user].delete("password_confirmation")
    end

    @status = false
    if @user.update_attributes(params[:user])
      sign_in @user, :bypass => true
      @status = true
    end
  end

  def add_referral
    @referral = Referral.new(user_id: current_user.id, email: params[:friend_email])
    @referral.save
  end

  def add_shipping_address
    @user = User.find(current_user.id)
    @sa = ShippingAddress.new(params[:shipping_address])

    if @sa.valid?
      @user.shipping_addresses << @sa
      @user.save
    end
  end

  def selected_shipping
    @user = User.find(current_user.id)
    @sa = ShippingAddress.find(params[:address_id])
    @user.shipping_addresses.each do |a|
      a.selected_shipping = (a.id == @sa.id ? true : false)
      a.save
    end
    render json: {status: 'saved'}
  end

  def rental_months
    @user = User.find(current_user.id)
    @user.rental_months = params[:months]
    @user.save
    render json: {status: 'saved'}
  end

  private

  def determine_layout
    case action_name
    when 'my_account'
      'app'
    else
      'application'
    end
  end

end