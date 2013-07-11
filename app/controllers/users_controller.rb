class UsersController < ApplicationController
  before_filter :authenticate_user!, except: [:create]

  def create
    user = User.new params.permit(:email, :password, :password_confirmation)
    user.ensure_authentication_token
    if user.save
      render json: user, status: :created
    else
      render json: {errors: user.errors}, status: :unprocessable_entity
    end
  end

  def show
    render json: current_user || {}
  end
end
