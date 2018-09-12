class Api::V1::HouseholdsController < ApplicationController
  before_action :set_household, only: [:show]

  def create
    @household = Household.new(household_params)

    if @household.save && User.find(params[:user_id]).update(household_id: @household.id)
      render json: @household
    else
      render json: { error: "Could not create Household" }
    end
  end

  def show
    render json: @household
  end

  private
  def set_household
    @household = Household.find(params[:id])
  end

  def household_params
    params.require(:household).permit(:name, :key)
  end
end
