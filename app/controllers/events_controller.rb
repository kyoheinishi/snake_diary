class EventsController < ApplicationController
  before_action :move_to_index, except: [:index]
  before_action :user_move_to_index, only: [:show, :edit, :update, :destroy]
  
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
    params.require(:event).permit(:title, :content, :start_time, :image).merge(user_id: current_user.id)
  end

  def move_to_index
    unless user_signed_in?
      redirect_to action: :index
    end
  end

  def user_move_to_index
    event = Event.find(params[:id])
    if event.user_id != current_user.id
      redirect_to action: :index
    end
  end

end
