class Admin::CourierTransitsController < AdminController
  def update
    @ct = CourierTransit.find(params[:id])
    @ct.update_attributes(params[:courier_transit])
    render nothing: true
  end
end
