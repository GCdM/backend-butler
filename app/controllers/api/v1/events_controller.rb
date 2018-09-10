class Api::V1::EventsController < ApplicationController
  before_action :set_event_user, only: [:accept, :reject]

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

  private
  def set_event_user
    @event_user = EventUser.find(params[:id])
  end
end
