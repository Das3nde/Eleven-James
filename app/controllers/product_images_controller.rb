class Admin::ProductImagesController < ApplicationController

  include Magick

  def create
    img = ProductImage.create( params[:product_image] )
    render :json => {:thumb_src => img.image.url('square'), :id => img.id}
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
    render :json => {:src => @img.url('square')}
  end
  def index
    render :nothing => true
  end
end
