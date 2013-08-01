class Admin::CourierTransitsController < AdminController
  #authentication before filter is in admin controller
  def update
    @ct = CourierTransit.find(params[:id])
    @ct.update_attributes(params[:courier_transit])
    render nothing: true
  end
end
