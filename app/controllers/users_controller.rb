class UsersController < ApplicationController

  def create
    user = User.new params.require(:user).permit(:email, :password, :password_confirmation)

    if user.save
      render json: user
    else
      render json: user, status: 422
    end
  end

  def show
    render json: current_user || {}
  end
end
