class Admin::MembersController < ApplicationController
  layout 'admin'
  #TODO: admin authorization and to be done across all admin controllers

  def index
    set_watch_metrics()
    paginate_user()
  end

  def page_members
    set_watch_metrics()
    paginate_user()
    render layout: false
  end

  def show
    @user = User.find(params[:id])
    @brands = Product.get_options('brand')
    @tiers= Product.get_options('collection')

    @diameter = Product.get_options('dial_style')
    @status = []
  end

  def approval
    @user = User.find(params[:user_id])

    case params[:approval]
    when 'approve'
      @user.approve
    when 'unapprove'
      @user.unapprove
    end

    render json: { status: 'success'}
  end

  def page_member_que
    @user = User.find(params[:user_id])
    @sort_column = params[:sort_column]
    @sort_order = params[:sort_order]
    @sort_column ||= 'model'
    @sort_order ||= 'DESC'

    @products = Product.select("products.brand, products.model, products.quantity, product_requests.created_at").joins("join product_requests on products.id = product_requests.product_id").where("product_requests.user_id = ?", @user.id).order("#{@sort_column} #{@sort_order}")

    render layout: false
  end

  def page_member_rotation_history
    @user = User.find(params[:user_id])
    @sort_column = params[:sort_column]
    @sort_order = params[:sort_order]
    @sort_column ||= 'model'
    @sort_order ||= 'DESC'

    @products = Product.select("products.brand, products.model, products.quantity, rotations.created_at").joins("join product_instances on products.id = product_instances.product_id join rotations on product_instances.id = rotations.product_instance_id").where("rotations.user_id = ?", @user.id).order("#{@sort_column} #{@sort_order}")
    render layout: false
  end

  def prospects
    set_watch_metrics()
    params[:page] ||= 1
    params[:per_page] ||= 10
    @sort_column = params[:sort_column]
    @sort_order = params[:sort_order]
    @sort_column ||= 'name'
    @sort_order ||= 'DESC'

    @prospects = Referral.select("referrals.name, referrals.email, users.name as user_fullname").joins("join users on referrals.user_id = users.id").order("#{@sort_column} #{@sort_order}").page(params[:page]).per(params[:per_page])
    render layout: false
  end

  def search_prospect
    @prospects = Referral.where("lower(name) like ?", "%#{params[:term].downcase.strip}%")
    render layout: false
  end

  def prospect_invitation
    @status = false
    if !params[:invite_name].blank? and !params[:invite_email].blank? and !params[:invite_message].blank?
      Notify.invitation(params[:invite_name], params[:invite_email], params[:invite_message]).deliver
      @status = true
    end
    render layout: false
  end

  private

  def paginate_user
    params[:page] ||= 1
    params[:per_page] ||= 10
    @sort_column = params[:sort_column]
    @sort_order = params[:sort_order]
    @sort_column ||= 'name'
    @sort_order ||= 'DESC'

    @users = User.select("count(*) as queue_count, users.id, users.name, users.payment_mode, users.paid_till").joins("left join product_requests on users.id = product_requests.user_id").page(params[:page]).per(params[:per_page]).order("#{@sort_column} #{@sort_order}").group("users.id, users.name, users.payment_mode, users.paid_till")
  end

  def set_watch_metrics
    @brands = Product.get_options('brand')
    @tiers= Product.get_options('collection')
    @diameter = Product.get_options('dial_style')
    @status = []
  end

end
