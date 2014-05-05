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
  	@user = User.create(user_params)
    rooms = params[:user][:rooms].to_s.to_i
  	if rooms && @user.save
      rooms.times{|i| @user.rooms.create(name: "room-#{i+1}")}
      session[:user_id] = @user.id
  		redirect_to inventory_path
  	else
  	  redirect_to root_path
  	end
  end

private

  def user_params
  	params.require(:user).permit(:email)
  end
end
