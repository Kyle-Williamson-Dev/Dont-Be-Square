class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :show]

  def new
    @event = Event.new
  end

  def show
    @event = Event.find_by_id(params[:id])
    if @event.blank?
      render plain: 'Not Found :(', status: :not_found
    end
  end

  def index
  end

  def create
    @event = current_user.events.create(event_params)
    if @event.valid?
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).permit(:description)
  end

end