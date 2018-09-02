class Api::V1::UsersController < ApplicationController

  def create
    @user = User.create(username: params[:username], display_name: params[:display_name], password: params[:password])

    if @user.valid?
      render json: @user
    else
      render json: { error: "Error Message: could not create account" }
    end
  end

  def login
    @user = User.find(username: params[:username])

    if @user && @user.authenticate(params[:password])
      render json: @user
    else
      render json: { error: "Error Message: could not find or authenticate user" }
    end
  end
end
