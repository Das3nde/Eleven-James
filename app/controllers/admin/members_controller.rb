class Admin::MembersController < ApplicationController
  layout 'admin'
  #TODO: admin authorization and to be done across all admin controllers

  def index
    @brands = Product.get_options('brand')
    @tiers= Product.get_options('collection')
    @diameter = Product.get_options('dial_style')
    @status = []

    params[:page] ||= 1
    params[:per_page] ||= 2
    @sort_column = params[:order]
    @sort_order = params[:order_by]
    @sort_column ||= 'name'
    @sort_order ||= 'DESC'
    @users = User.page(params[:page]).per(params[:per_page]).order("#{@sort_column} #{@sort_order}")
  end

  def page_members
    @brands = Product.get_options('brand')
    @tiers= Product.get_options('collection')
    @diameter = Product.get_options('dial_style')
    @status = []

    params[:page] ||= 1
    params[:per_page] ||= 2
    @sort_column = params[:order]
    @sort_order = params[:order_by]
    @sort_column ||= 'name'
    @sort_order ||= 'DESC'
    @users = User.page(params[:page]).per(params[:per_page]).order("#{@sort_column} #{@sort_order}")
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

end
