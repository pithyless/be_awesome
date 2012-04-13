class SessionsController < ApplicationController

  skip_before_filter :check_sign_in, :only => [:create]

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_facebook_uid(auth["uid"]) || User.create_with_facebook(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

end
