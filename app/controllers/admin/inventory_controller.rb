class Admin::InventoryController < AdminController
  before_filter :append_view_paths
  helper_method :tabs

  def tabs
    {:inventory => 'Inventory',
    :arrange_transit => 'Arrange Transit',
    :past_due => 'Past Due',
    :purchase_request => 'Purchase Request'
    }
  end

  def append_view_paths
    append_view_path 'app/views/admin/inventory/record_forms'

  end

  def index
    @products = ProductInstance.all
  end
  def show
    id = params[:id]
    @product_instance = ProductInstance.find(id)
    @history = @product_instance.history()
    @d = CourierTransit.new()
  #  @debug.bin_number = 5423
    @d.product_id = params[:id]
    @d.is_signature_required  = true
    @d.table = @d.class.name.tableize;

    @f = FedexTransit.new()
  #  @debug.bin_number = 5423
    @f.product_id = params[:id]
    @f.table = @f.class.name.tableize;
  end
  def add_record
    product_id = params[:id]
  end

  #tab actions
  def inventory
    render :nothing => true
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
end
