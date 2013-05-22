class Admin::InventoryController < ApplicationController
  before_filter :append_view_paths

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
    prdouct_id = params[:id]
  end
end
