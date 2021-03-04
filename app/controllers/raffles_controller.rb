class RafflesController < ApplicationController
  before_action :set_raffle, only: [:show, :edit, :update]
 
    def index
      @raffles = Raffle.filter(params[:filter]).where(winner: nil)
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
      bid_gold = params[:raffle][:gold].to_i
      bid_silver = params[:raffle][:silver].to_i
      bid_bronze = params[:raffle][:bronze].to_i
      bid_total = (bid_gold*3)+(bid_silver*2)+(bid_bronze)
      if bid_gold > current_user.user_gold || bid_silver > current_user.user_silver || bid_bronze > current_user.user_bronze
        redirect_to edit_raffle_path, notice: "You do not have enough tickets."
      else 
        if bid_total + @raffle.current_bids > @raffle.number_of_ticket_slots    
        redirect_to edit_raffle_path, notice: "There aren't enough spots left in this raffle to handle your entry! Please use less tickets."
        else @raffle.update_tickets(current_user, bid_gold, bid_silver, bid_bronze)
          if @raffle.slots_filled?
          @raffle.select_winner
          end
        end
       redirect_to edit_raffle_path(@raffle)
      end
    end

    def delete
      params[:filter].clear
    end

    private 

    def raffle_params
      params.require(:raffle).permit(:product_name, :product_description, :product_image, :number_of_ticket_slots, :filter)
    end
    
    def set_raffle
      @raffle = Raffle.find(params[:id])
    end

    def filtering_params(params)
      params.slice(:category)
    end   
  
end