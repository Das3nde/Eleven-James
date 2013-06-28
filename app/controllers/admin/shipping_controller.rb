class Admin::ShippingController < AdminController
  @@tabs = {
      index: 'Pickup From 11James',
      from_member: 'Pickup From Member',
      my_pickups: 'My Pickups'
  }

  def index
    @foo = 'bar'
    if request.xhr?
      render :file => 'admin/products/products'
    end
  end

  def my_pickups
    transits = CourierTransit.where('courier_id = ?',current_user.id)
    @possessed = []
    @awaiting = []
    transits.each do |t|
      if t.product_instance.status_id == t.id
        @possessed << t
      end
      if t.product_instance.next_status_id == t.id
        @awaiting << t
      end
    end
    render('admin/shipping/my_pickups')
  end

  def pickup
    move_record('forward')
  end

  def cancel_pickup
    move_record('back')
  end

  def mark_delivered
    move_record('forward')
  end

  def move_record direction
    status = CourierTransit.find(params[:id])
    begin
      product_instance = get_courier_instance(status)
    rescue Exception => e
      if(e.class == ForbiddenError)
        return render status: 403
      else
        raise e
      end
    end
    meth = direction == 'back' ? 'retreat_record' : 'advance_record'
    product_instance.send(meth)
    return my_pickups()
  end

  private
    def set_tabs
      @tabs = @@tabs.reject{|tab| tab==:my_pickups and !current_user.has_role 'Courier'}
    end

    def get_courier_instance transit
      product_instance = transit.product_instance
      if transit.courier_id != current_user.id
        raise ForbiddenError.new('Unauthorized')
      end
      return product_instance
    end

end

class ForbiddenError < RuntimeError
end