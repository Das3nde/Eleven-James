class Admin::EventsController < AdminController
  def index
    @events = Event.all()
  end
  def new
    if params[:copy_id]
      @existing = Event.find(params[:copy_id])
      @event = @existing.clone
    else
      @event = Event.new()
    end
    render "admin/events/create_edit"
  end
  def edit
    @event = Event.find(params[:id])
    render "admin/events/create_edit"
  end
  def update
    event = Event.find(params[:id])
    if event.update_attributes params[:event]
      redirect_to admin_events_path
    else
      render :action => :edit
    end
  end
  def create
    @event = Event.new(params[:event])
    @event.save()
    redirect_to admin_events_path
  end

end