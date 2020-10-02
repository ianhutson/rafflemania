class WelcomeController < ApplicationController
    def home
        @user = User.new
    end

    def info
        @user = User.new
    end
end