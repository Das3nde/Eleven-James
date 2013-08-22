class EventsController < ApplicationController

  layout 'app'

  def index
    @wrapper = "marketing"
    @events = Event.published.order("date DESC")
    @upcoming_events = Event.published.where("date > ?", Time.now).order("date DESC")
  end

  def show
    @wrapper = "marketing"
    @event = Event.find(params[:id])
  end

end
