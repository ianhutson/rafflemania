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
      if helpers.bid_total + helpers.current_bids(@raffle) > @raffle.number_of_ticket_slots
        if helpers.bid_gold > helpers.user_gold(current_user) || helpers.bid_silver > helpers.user_silver(current_user) || helpers.bid_bronze > helpers.user_bronze(current_user)
          redirect_to edit_raffle_path, notice: "You do not have enough tickets."
        else
        redirect_to edit_raffle_path, notice: "There aren't enough spots left in this raffle to handle your entry! Please use less tickets."
        end
      else update_tickets(@raffle)
        if @raffle.number_of_ticket_slots == helpers.current_bids(@raffle) 
           @winner = @@raff_arr.sample
           @raffle.update(winner: @winner)
          #code to ship item to winner using amazon api
          Raffle.create(product_name: @raffle.product_name, product_description: @raffle.product_description, product_image: @raffle.product_image, category: @raffle.category, number_of_ticket_slots: @raffle.number_of_ticket_slots)
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