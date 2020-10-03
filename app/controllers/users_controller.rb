class UsersController < ApplicationController
    def index
    end

    def new
        @user = User.new
    end
  
    def create
      if @user = User.find_by(email: params[:email])
        redirect_to new_user_path, notice: "Email in use."
      else @user =  User.create(username: params[:email], email: params[:email], password_digest: params[:password_digest])
        session[:user_id] = @user.id
        redirect_to edit_user_path(@user), notice: 'Because this a new account, we will need a bit more info before you can start participating in raffles.'
      end
    end
  
    def show
      @user = User.find_by(id: params[:id])
      redirect_to root_url
    end

    def edit
     @user = current_user
    end

    def update 
      @user = current_user
      if @user.update(user_params)
        @user.save
        redirect_to root_url
      else
        redirect_to edit_user_path(@user)
      end
    end
    
     private
  
     def user_params
      params.require(:user).permit(:username, :password_digest, :password_digest_confirm, :tickets, :shipping_address, :city, :state, :zip, :shipping_name, :email, :id)
    end
  end