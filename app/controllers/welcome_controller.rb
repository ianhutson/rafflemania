class WelcomeController < ApplicationController
    def home
        @user = User.new
        redirect_to raffles_path
    end

    def info
        @user = User.new
    end
end