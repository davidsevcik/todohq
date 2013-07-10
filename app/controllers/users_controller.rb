class UsersController < ApplicationController

  def create
    user = User.new params.require(:user).permit(:email, :password, :password_confirmation)

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
