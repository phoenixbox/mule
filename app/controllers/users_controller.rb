class UsersController < ApplicationController

  def show
    @user = User.find(session[:user_id])
    if @user
      render json: @user
    else
      render json: {errors: "User Not Found"}, status: 404
    end
  end

  def create
  	@user = User.create!(user_params)
    @user.rooms.create(name: "room-1")
    session[:user_id] = @user.id
    redirect_to inventory_path
  end

private

  def user_params
    {email: "#{Time.now.to_i}@example.com"}
  end
end
