class Admin::ProductImagesController < ApplicationController

  include Magick

  before_filter :super_admin_required

  def create
    attrs = params[:product_image]
    attrs[:rank] = ProductImage.where('product_id = 1').size
    img = ProductImage.create( attrs )
    if(img.valid?)
      render :json => {:thumb_src => img.image.url('square'), :id => img.id}
    else
      render :status => 400, :json => {:error => "Must be an image file"}
    end
  end

  def show
    @img = ProductImage.find(params[:id])
    img = ::Magick::Image::read(@img.path('medium')).first
    @width = img.columns
    @height = img.rows
  end

  def update
    @img = ProductImage.find(params[:id])
    img = ::Magick::Image::read(@img.path('medium')).first

    square = img.crop(params[:x].to_i,params[:y].to_i,params[:w].to_i,params[:h].to_i)
    square = square.adaptive_resize(200,200);
    square.write(@img.path("square"))

    public = img.crop(params[:x].to_i,params[:y].to_i,params[:w].to_i,params[:h].to_i)
    public = public.adaptive_resize(359,293);
    public.write(@img.path("public"))



    render :json => {:src => @img.url('square')}
  end
  def index
    render :nothing => true
  end
  def destroy
    ProductImage.find(params[:id]).destroy
    render :nothing => true
  end
end
