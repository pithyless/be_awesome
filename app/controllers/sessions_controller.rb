class SessionsController < ApplicationController

  skip_before_filter :check_sign_in, :only => [:create]

  def create
    auth = request.env["omniauth.auth"]
    user = User.login_via_facebook(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def friends
    render :json => current_user.facebook_friends.to_json
  end

end
