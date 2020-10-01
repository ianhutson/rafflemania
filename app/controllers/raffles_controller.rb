class RafflesController < ApplicationController
    def index
        @raffles = raffle.all
    end
    
    def new
        @raffle = raffle.new
        # @ticket = @raffle.tickets.build(user_id: current_user.id)
     end
    
    def show
        @raffle = raffle.find_by(id: params[:id])
    end
    
    def create
        @raffle = raffle.new(raffle_params)
        if @raffle.save
          redirect_to raffle_path(@raffle)
        else
          render :new
        end
    end
    
    def edit
        @raffle = raffle.find_by(id: params[:id])
        # @ticket = @raffle.tickets.build(user_id: current_user.id)
    end
    
    def update
        @raffle = raffle.find_by(id: params[:id])
        if @raffle.update(raffle_params)
          redirect_to raffle_path(@raffle)
        else
          render :new
        end
    end
    
    private
    
    def raffle_params
        params.require(:raffle).permit(:product_name, :product_description, :product_image, :number_of_ticket_slots)
    end
end
