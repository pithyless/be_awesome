class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_sign_in

  helper_method :current_user

  private

  def check_sign_in
    unless current_user
    redirect_to '/auth/facebook'
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
