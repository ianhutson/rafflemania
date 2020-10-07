class UsersController < ApplicationController
    def index
      @user = User.find_by(id: params[:id])
    end

    def new
      @user =  User.new
    end
  
    def history
      @user = User.find_by(id: params[:id])
    end

    def edit
      @user = User.find_by(id: params[:id])
    end

    def update 
      @user = User.find_by(id: params[:id])
      if @user.update(user_params)
        @user.save
        redirect_to root_url
      else
        redirect_to edit_user_path(@user)
      end
    end
    
     private
  
     def user_params
      params.require(:user).permit(:username, :password, :password_confirmation, :tickets, :shipping_address, :city, :state, :zip, :shipping_name, :email, :id, :current_password)
    end
  end