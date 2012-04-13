class SessionsController < ApplicationController

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_facebook_uid(auth["uid"]) || User.create_with_facebook(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

end
