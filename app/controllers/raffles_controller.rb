class RafflesController < ApplicationController
  before_action :set_raffle, only: [:show, :edit, :update]


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
      if (set_gold * 3) + (set_silver * 2) + set_bronze + (@raffle.tickets.where(:tier => :gold).count.to_i*3) + (@raffle.tickets.where(:tier => :silver).count.to_i*2) + (@raffle.tickets.where(:tier => :bronze).count.to_i) > @raffle.number_of_ticket_slots
        if set_gold > current_user.tickets.where(tier: 'gold').count || set_silver > current_user.tickets.where(tier: 'silver').count || set_bronze > current_user.tickets.where(tier: 'bronze').count
          redirect_to edit_raffle_path, notice: "You do not have enough tickets."
        else
        redirect_to edit_raffle_path, notice: "There aren't enough spots left in this raffle to handle your entry! Please use less tickets."
        end
      else set_gold.times {current_user.tickets.find_by(tier: 'gold', used: false).update(:used => true, :raffle_id => @raffle.id)}
           set_silver.times {current_user.tickets.find_by(tier: 'silver', used: false).update(:used => true, :raffle_id => @raffle.id)}
           set_bronze.times {current_user.tickets.find_by(tier: 'bronze', used: false).update(:used => true, :raffle_id => @raffle.id)}
           raff_arr = []
           raff_arr.fill(current_user.username, raff_arr.size, set_gold*3)
           raff_arr.fill(current_user.username, raff_arr.size, set_silver*2)
           raff_arr.fill(current_user.username, raff_arr.size, set_bronze )
        if @raffle.number_of_ticket_slots == (@raffle.tickets.where(:tier => :gold).count.to_i*3) + (@raffle.tickets.where(:tier => :silver).count.to_i*2) + (@raffle.tickets.where(:tier => :bronze).count.to_i) 
           @winner = raff_arr.sample
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