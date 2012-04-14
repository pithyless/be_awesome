class SessionsController < ApplicationController

  skip_before_filter :check_sign_in, :only => [:create]

  def create
    auth = request.env["omniauth.auth"]
    user = User.login_via_facebook(auth)
    session[:user_id] = user.id
    redirect_to root_url
  end

  def friends
    token = current_user.facebook_access_token
    friends = "https://graph.facebook.com/me/friends?access_token=#{token}"
    render :json => friends.to_json
  end

end
