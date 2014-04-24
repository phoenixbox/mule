class UserOwnedController < ApplicationController
  before_action :require_user

  def require_user
    unless @current_user
      render json: {message: "User Not Found"}, status: :unprocessable_entity
      return
    end
  end
end
