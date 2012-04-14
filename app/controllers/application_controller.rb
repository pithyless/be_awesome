class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_sign_in

  helper_method :current_user

  private

  def check_sign_in
    if Rails.env.development?
      user = User.find('4f889af5e756a90003000001')
      session[:user_id] = '4f889af5e756a90003000001'
      @current_user = user
    end

    unless current_user
      redirect_to '/auth/facebook'
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
