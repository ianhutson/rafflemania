class RafflesController < ApplicationController

    def index
      @raffles = Raffle.filter(params[:filter])
    end

    def new
        @raffle = Raffle.new
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
    end
    
    def update
        @raffle = Raffle.find_by(id: params[:id])
        if params[:raffle][:gold].to_i + params[:raffle][:silver].to_i + params[:raffle][:bronze].to_i < Raffle.find_by(id: params[:id]).number_of_ticket_slots
          params[:raffle][:gold].to_i*3.times {current_user.tickets.where(tier: 'gold', used: false).update(:used => true, :raffle_id => @raffle.id)}
          params[:raffle][:silver].to_i*2.times {current_user.tickets.where(tier: 'silver', used: false).update(:used => true, :raffle_id => @raffle.id)}
          params[:raffle][:bronze].to_i.times {current_user.tickets.where(tier: 'bronze', used: false).update(:used => true, :raffle_id => @raffle.id)}
          redirect_to edit_raffle_path(@raffle)
        else
          render :edit, notice: "There aren't enough spots left! Please use less tickets."
        end
    end
    
    private
    
    def raffle_params
        params.require(:raffle).permit(:product_name, :product_description, :product_image, :number_of_ticket_slots, :filter)
    end

    def filtering_params(params)
      params.slice(:category)
    end
end
