class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:new,:create]

  def new
    user = User.new
  end
  
  def create
    if auth = nil
      @user = User.find_or_create_by(email: params[:email], password_digest: params[:password_digest])
      session[:user_id] = @user.id
    else
    session[:user_id] = User.find_or_create_by(email: request.env['omniauth.auth']["info"]['email'], password_digest: random_password, username: params[:email],).id 
    redirect_to root_url
    end
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