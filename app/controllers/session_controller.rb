class SessionController < ApplicationController
  after_filter :logout_user, only[:destroy]

  def destroy
    @user = User.find(session[:user_id])
    if @user
      render json: {message: "Logged Out!"}, status: 204
    else
      render json: {error: "User Not Found" }, status: 404
    end
  end

private

  def logout_user
    session[:user_id] = nil
  end
end
