class UsersController < ApplicationController

  def create
  	params.permit!
  	@user = User.create(params[:user])
  	if @user.save
  		render :json => @user
  	else
  	  render :json => { :errors => @user.errors.full_messages }, :status => 422
  	end
  end



  private

	def user_params
	  params.require(:user).permit(:email)
	end
end