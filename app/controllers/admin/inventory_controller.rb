class Admin::InventoryController < AdminController
  before_filter :append_view_paths
  @tabs = {:inventory => 'Inventory',
    :arrange_transit => 'Arrange Transit',
    :past_due => 'Past Due',
    :purchase_request => 'Purchase Request'
    }

  def append_view_paths
    append_view_path 'app/views/admin/inventory/record_forms'

  end

  def index
    @products = ProductInstance.order('id DESC')
  end
  def show
    id = params[:id]
    @product_instance = ProductInstance.find(id)
    @history = @product_instance.history()
    @future = @product_instance.future()
    @status = @product_instance.status
    render :layout=> false
  end
  def add_record
    product_id = params[:id]
  end

  #tab actions
  def inventory
    @product_instances = ProductInstance.all
    render :layout=>false, :file => 'admin/inventory/_inventory'
  end
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
    render :json => [transit_record.id, record.id]
  end
end
