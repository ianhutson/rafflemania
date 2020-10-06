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
        if (params[:raffle][:gold].to_i*3 + params[:raffle][:silver].to_i*2 + params[:raffle][:bronze].to_i) + (@raffle.tickets.where(:tier => :gold).count.to_i*3) + (@raffle.tickets.where(:tier => :silver).count.to_i*2) + (@raffle.tickets.where(:tier => :bronze).count.to_i) > Raffle.find_by(id: params[:id]).number_of_ticket_slots
          render :edit, notice: "There aren't enough spots left! Please use less tickets."
        else params[:raffle][:gold].to_i.times {current_user.tickets.find_by(tier: 'gold', used: false).update(:used => true, :raffle_id => @raffle.id)}
          params[:raffle][:silver].to_i.times {current_user.tickets.find_by(tier: 'silver', used: false).update(:used => true, :raffle_id => @raffle.id)}
          params[:raffle][:bronze].to_i.times {current_user.tickets.find_by(tier: 'bronze', used: false).update(:used => true, :raffle_id => @raffle.id)}
          raff_arr = []
          raff_arr.fill(current_user.username, raff_arr.size, params[:raffle][:gold].to_i )
          raff_arr.fill(current_user.username, raff_arr.size, params[:raffle][:silver].to_i )
          raff_arr.fill(current_user.username, raff_arr.size, params[:raffle][:bronze].to_i )
          if @raffle.number_of_ticket_slots == (@raffle.tickets.where(:tier => :gold).count.to_i*3) + (@raffle.tickets.where(:tier => :silver).count.to_i*2) + (@raffle.tickets.where(:tier => :bronze).count.to_i) 
            @winner = raff_arr.sample
            #code to ship item to winner
            @raffle.update(winner: @winner)
            Raffle.create(product_name: @raffle.product_name, product_description: @raffle.product_description, product_image: @raffle.product_image, category: @raffle.category, number_of_ticket_slots: @raffle.number_of_ticket_slots)
         end
         redirect_to edit_raffle_path(@raffle)
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
