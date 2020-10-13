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
  end