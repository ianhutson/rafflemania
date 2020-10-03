class UsersController < ApplicationController
    def index
    end

    def new
        @user = User.new
    end
  
    def create
       if @user = User.find_by(email: user_params[:email]) 
         if @user.password_digest == user_params[:password_digest]
          session[:user_id] = @user.id
          redirect_to root_url
         else redirect_to root_url, notice: 'Invalid password.'
         end
       elsif @user = User.new(username: params[:email], email: params[:email], password_digest: params[:password_digest], password_digest_confirm: params[:password_digest_confirm])
        if @user.save
        session[:user_id] = @user.id
        redirect_to edit_user_path(@user), notice: 'Because this a new account, we will need a bit more info before you can start participating in raffles.'
        else render :new
        end
      end
    end
  
    def show
      @user = User.find_by(id: params[:id])
      redirect_to root_url
    end

    def edit
     @user = User.find_by(id: session[:user_id])
    end

    def update 
      puts user_params
      @user = User.find_by(id: session[:user_id])
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