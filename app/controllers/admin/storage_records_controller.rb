class Admin::StorageRecordsController < AdminController
  def update
    @record = StorageRecord.find(params[:id])
    @record.update_attributes(params[:storage_record])
    @record.product_instance.update_attribute(:is_available,
        params[:storage_record][:is_available])
    render :json => {:ok => true}
  end
end