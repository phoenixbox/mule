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
  	params.permit!
  	@user = User.create(params[:user])
  	if @user.save
      session[:user_id] = @user.id
  		render :json => @user
  	else
  	  render :json => { :errors => @user.errors.full_messages }, :status => 422
  	end
  end
end
