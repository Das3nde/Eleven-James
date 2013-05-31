class Admin::VendorsController < ApplicationController
  def create
    vendor = Vendor.new(params[:vendor])
    if vendor.save()
      render :json => vendor, :status => 200, :content_type => 'application/json'
    else
      render :nothing => true, :status => 400, :content_type => 'text/html'
    end
  end
end
