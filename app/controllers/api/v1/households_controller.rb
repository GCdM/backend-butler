class Api::V1::HouseholdsController < ApplicationController
  before_action :set_household, only: [:show]

  def show
    render json: @household
  end

  private
  def set_household
    @household = Household.find(params[:id])
  end

  def household_params

  end
end
