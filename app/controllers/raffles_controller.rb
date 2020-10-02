class RafflesController < ApplicationController
    def index
        @raffles = Raffle.all
    end
    
    def new
        @raffle = Raffle.new
        # @ticket = @raffle.tickets.build(user_id: current_user.id)
     end
    
    def show
        @raffle = Raffle.find_by(id: params[:id])
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
        @raffle = Raffle.find_by(id: params[:id])
        # @ticket = @raffle.tickets.build(user_id: current_user.id)
    end
    
    def update
        @raffle = Raffle.find_by(id: params[:id])
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
