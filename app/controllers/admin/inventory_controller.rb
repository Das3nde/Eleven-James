class Admin::InventoryController < AdminController

  #authentication before filter is in admin controller

  before_filter :append_view_paths

  @@tabs = {:index => 'Inventory',
           :past_due => 'Past Due',
           :purchase_request => 'Purchase Request'
  }
  def append_view_paths
    append_view_path 'app/views/admin/inventory/record_forms'

  end

  def index
    @products = ProductInstance.order('cast(id as unsigned) asc')
    if request.xhr?
      @product_instances = ProductInstance.order('id asc')
      render :file => 'admin/inventory/_inventory'
    end
  end

  def show
    @products = ProductInstance.order('id DESC')
    if request.xhr?
      return _show()
    end
    render :file => 'admin/inventory/index'
  end
  def add_record
    product_id = params[:id]
  end

  #tab actions
  def arrange_transit
    render :nothing => true
  end
  def past_due
    render :nothing => true
  end
  def purchase_request
    render :nothing => true
  end
  def remove_record
    record = Record.find(params[:id])
    transit_record = record.prev
    transit_record.destroy()
    record.destroy()
    _show(record.product_instance)
  end
  def process_transit
    @transits = ProductInstance.where("next_status_table ~ 'transits'")
  end

  def add_service
    @product_instance = ProductInstance.find(params[:id])
    @product_instance.remove_future_records()
    @product_instance.add_service(Vendor.find(params[:service][:vendor_id]))
    _show(@product_instance)
  end

  def status
    @status = Record.find(params[:id]).status
    @future = @status.class == StorageRecord && @status.product_instance.future();
    render :file => 'admin/inventory/record_forms/_'+@status.class.to_s.underscore
  end

  def change_transit
    record = Record.find(params[:id])

    new_transit_class = (params[:transit][:transit_type] + 'Transit').constantize

    record.switch_status(new_transit_class)
    record.save
    _show(record.product_instance)
  end



  private
    def _show(product_instance = nil)
      @product_instance = product_instance || ProductInstance.find(params[:id])
      @history = @product_instance.history()
      @future = @product_instance.future()
      @status = params[:status_id] ? Record.find(params[:status_id]).status : @product_instance.status
      @couriers = User.with_role :courier

      render :file => 'admin/inventory/show'
    end
    def set_tabs
      @tabs = {:index => 'Inventory',
               :past_due => 'Past Due',
               :purchase_request => 'Purchase Request'
      }
    end
end
