class SessionsController < ApplicationController

  def create
    @user = User.where(email: user_params[:email]).first
    login_user
  end


  def destroy
    @user = User.find(session[:user_id])
    session[:user_id] = nil
    if @user
      render json: {message: "Logged Out!"}, status: 204
    else
      render json: {error: "User Not Found" }, status: 404
    end
  end

private

  def login_user
    if @user
      @current_user = @user
      session[:user_id] = @user.id
      redirect_to inventory_path
    else
      redirect_to root_path
    end
  end

  def logout_user
    session[:user_id] = nil
  end
end
