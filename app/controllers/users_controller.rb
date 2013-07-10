class UsersController < ApplicationController
  def create
    user = User.new params.require(:user).permit(:email, :password, :password_confirmation)

    if user.save
      render json: user, status: :created
    else
      respond_with user
    end
  end
end
