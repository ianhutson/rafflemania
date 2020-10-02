class UsersController < ApplicationController
    # before_action :require_login, only: [:show]
    validates_uniqueness :username
    validates :email,
    format: { with: /^(.+)@(.+)$/, message: "Email invalid"  },
              uniqueness: { case_sensitive: false },
              length: { minimum: 4, maximum: 254 } 
    def new
      @user = User.new
    end
  
     def create
      @user = User.new(user_params)
       if @user.save
        session[:user_id] = @user.id
        redirect_to edit_user_path(@user), notice: 'Because this a new account, we will need a bit more info before you can start participating in raffles.'
      else
        render :new
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
      @user = User.find_by(id: session[:user_id])
      @user.update(user_params)
      if @user.valid?
        redirect_to user_path(@user)
      else
        render :edit
      end
    end

     private
  
     def user_params
      params.require(:user).permit(:username, :password_digest, :tickets, :shipping_address, :shipping_city_state_zip, :shipping_name, :email, :id)
    end
  end