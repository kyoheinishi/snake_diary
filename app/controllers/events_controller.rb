class EventsController < ApplicationController
  
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def create
    Event.create(event_parameter)
    redirect_to root_path
  end

  def show
    @event = Event.find(params[:id])
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_parameter)
      redirect_to root_path
    else
      render :show
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
      redirect_to root_path
  end



  private

  def event_parameter
    params.require(:event).permit(:title, :content, :start_time)
  end

end
