class Api::V1::ResponsibilitiesController < ApplicationController
  before_action :set_responsibility, only: [:create_log]

  def create
    @responsibility = Responsibility.new(responsibility_params)

    if @responsibility.save
      render json: @responsibility
    else
      render json: { error: "Could not create responsibility" }
    end
  end

  def create_log
    @log = ResponsibilityUser.new(log_params)

    if @log.save
      render json: @log
    else
      render json: @log.errors.full_messages
    end
  end

  private
  def responsibility_params
    params.require(:responsibility).permit(:household_id, :title)
  end

  def set_responsibility
    @responsibility = Responsibility.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:responsibility_id, :user_id, :description, :date)
  end
end
