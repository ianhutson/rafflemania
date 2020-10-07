class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:new,:create]

  def new
    user = User.new
  end
  
  def create
    session[:user_id] = User.find_or_create_by(email: request.env['omniauth.auth']["info"]['email']).id 
    redirect_to root_url
  end

  def destroy
    session.delete("user_id")
    redirect_to root_url
  end

  private
 def random_password
  (0...8).map{(65 + rand(26)).chr}.join
 end
end