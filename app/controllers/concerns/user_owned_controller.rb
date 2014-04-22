class UserOwnedController < ApplicationController
  before_action :require_user

  def require_user
    unless user
      render json: {message: "User Not Found"}, status: :unprocessable_entity
    end
  end

  def user
    if user_params
      @user = User.find_by_email(user_params[:key])
    else
      puts "poop"
      false
    end
  end

  def user_params
    binding.pry
    params.require(:user).permit(:key).with_indifferent_access
  end
end
