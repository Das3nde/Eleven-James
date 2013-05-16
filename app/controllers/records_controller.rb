class RecordsController < ApplicationController

end


class Admin::RecordsController < ApplicationController
  def create
    model_name = controller_name.classify
    model = model_name.constantize.new();
    params[model_name.underscore].each do |k,v|
      model.write_attribute(k,v)
    end
    model.id = UUID.generate
    model.table = model_name.tableize
    model.save()
    render  :json => model.to_json

  end
  def update

  end
  def destroy
    record = Record.find(params[:id])
    record.destroy
    render :nothing=>true
  end
end