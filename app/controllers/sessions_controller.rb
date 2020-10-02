class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:new,:create]

  def new
    user = User.new
  end
  
  def create
    session[:user_id] = User.find_or_create_by(email: auth["info"]['email'], username: auth["info"]["email"]).id 
    puts session[:user_id]
    redirect_to root_url
  end

  def destroy
    session.delete("user_id")
    redirect_to root_url
  end

  private
 
  def auth
    request.env['omniauth.auth']
  end
end