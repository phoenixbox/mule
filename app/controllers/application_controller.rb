class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token

  before_filter :current_user?

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  def user_params
    params.require(:user).permit(:email)
  end

  private

  def current_user?
    !current_user
  end
end
