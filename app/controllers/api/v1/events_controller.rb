class Api::V1::EventsController < ApplicationController
  before_action :set_event_user, only: [:accept, :reject, :accept_house, :reject_house]

  def create
    @event = Event.new(event_params)

    if @event.save
      render json: @event
    else
      render json: { error: "Could not create event" }
    end
  end

  def accept
    if @event_user.update(status: "accepted")
      render json: @event_user.user, serializer: UserInfoSerializer
    else
      render json: { error: "Could not accept invitation" }
    end
  end

  def reject
    if @event_user.update(status: "rejected")
      render json: @event_user.user, serializer: UserInfoSerializer
    else
      render json: { error: "Could not reject invitation" }
    end
  end

  def accept_house
    if @event_user.update(status: "accepted")
      render json: @event_user.user.household, serializer: HouseholdSerializer
    else
      render json: { error: "Could not accept invitation" }
    end
  end

  def reject_house
    if @event_user.update(status: "rejected")
      render json: @event_user.user.household, serializer: HouseholdSerializer
    else
      render json: { error: "Could not reject invitation" }
    end
  end

  private
  def set_event_user
    @event_user = EventUser.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:household_id, :date, :title, :description)
  end
end
