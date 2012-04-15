class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_sign_in

  helper_method :current_user
  helper_method :facebook_logout_url

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

  def facebook_logout_url
    api_key = ENV['FACEBOOK_KEY']
    session_key = current_user.facebook_access_token
    "http://www.facebook.com/logout.php?api_key=#{api_key}&session_key=#{session_key}&confirm=1&next=http://be-awesome.herokuapp.com/auth/logout"
  end

end
