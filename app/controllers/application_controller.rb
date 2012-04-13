class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_sign_in

  helper_method :current_user

  private

  def check_sign_in
    if Rails.env.development?
      user = User.new.tap do |u|
        u.id = '424242'
        u.name = 'Billy Joel'
        u.email = 'billy@joel.com'
        u.avatar = 'http://profile.ak.fbcdn.net/hprofile-ak-snc4/573520_1180408451_1360557398_q.jpg'
      end
      session[:user_id] = '424242'
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
