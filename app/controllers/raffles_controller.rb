class RafflesController < ApplicationController
  before_action :set_raffle, only: [:show, :edit, :update]
  include RafflesHelper

    def index
      @raffles = Raffle.where(winner: nil)
    end

    def new
        @raffle = Raffle.new
    end
    
    def show
        redirect_to edit_raffle_path
    end
    
    def create
        @raffle = Raffle.new(raffle_params)
        if @raffle.save
          redirect_to raffle_path(@raffle)
        else
          render :new
        end
    end
    
    def edit
    end
    
    def update
      if helpers.enough_slots?(@raffle)
        if helpers.enough_tickets?(current_user)
          redirect_to edit_raffle_path, notice: "You do not have enough tickets."
        else
        redirect_to edit_raffle_path, notice: "There aren't enough spots left in this raffle to handle your entry! Please use less tickets."
        end
      else update_tickets(@raffle)
        if slots_filled?(@raffle)
          select_winner(@raffle)
        end
       redirect_to edit_raffle_path(@raffle)
      end
    end

    def delete
      params[:filter].clear
    end

    private 

    def set_raffle
      @raffle = Raffle.find(params[:id])
    end

    def raffle_params
      params.require(:raffle).permit(:product_name, :product_description, :product_image, :number_of_ticket_slots, :filter)
    end

    def filtering_params(params)
      params.slice(:category)
    end   
end