class UsersController < ApplicationController

  def show
    @user = User.find(session[:user_id])
    if @user
      render json: @user
    else
      render json: {errors: "User Not Found"}, status: 404
    end
  end

  def update
    session[:user] = params
  end

  def create
  	params.permit!
    rooms = params[:user].delete(:rooms)
  	@user = User.create(params[:user])
  	if @user.save
      session[:user_id] = @user.id
      session[:rooms] = rooms
  		render :json => @user
  	else
  	  render :json => { :errors => @user.errors.full_messages }, :status => 422
  	end
  end
end
