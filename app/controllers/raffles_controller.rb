class RafflesController < ApplicationController


    def index
      @raffles = Raffle.filter(params[:filter])
    end

    def new
        @raffle = Raffle.new
     end
    
    def show
        @raffle = Raffle.find_by(id: params[:id])
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
        @raffle = Raffle.find_by(id: params[:id])
    end
    
    def update
        @raffle = Raffle.find_by(id: params[:id])
        if (params[:raffle][:gold].to_i*3 + params[:raffle][:silver].to_i*2 + params[:raffle][:bronze].to_i) + (@raffle.tickets.where(:tier => :gold).count.to_i*3) + (@raffle.tickets.where(:tier => :silver).count.to_i*2) + (@raffle.tickets.where(:tier => :bronze).count.to_i) > Raffle.find_by(id: params[:id]).number_of_ticket_slots
          if params[:raffle][:gold].to_i > current_user.tickets.where(tier: 'gold').count || params[:raffle][:silver].to_i > current_user.tickets.where(tier: 'silver').count || params[:raffle][:bronze].to_i > current_user.tickets.where(tier: 'bronze').count
            redirect_to edit_raffle_path, notice: "You do not have enough tickets."
          else
          redirect_to edit_raffle_path, notice: "There aren't enough spots left in this raffle to handle your entry! Please use less tickets."
          end
        else params[:raffle][:gold].to_i.times {current_user.tickets.find_by(tier: 'gold', used: false).update(:used => true, :raffle_id => @raffle.id)}
          params[:raffle][:silver].to_i.times {current_user.tickets.find_by(tier: 'silver', used: false).update(:used => true, :raffle_id => @raffle.id)}
          params[:raffle][:bronze].to_i.times {current_user.tickets.find_by(tier: 'bronze', used: false).update(:used => true, :raffle_id => @raffle.id)}
          raff_arr = []
          raff_arr.fill(current_user.username, raff_arr.size, params[:raffle][:gold].to_i )
          raff_arr.fill(current_user.username, raff_arr.size, params[:raffle][:silver].to_i )
          raff_arr.fill(current_user.username, raff_arr.size, params[:raffle][:bronze].to_i )
          if @raffle.number_of_ticket_slots == (@raffle.tickets.where(:tier => :gold).count.to_i*3) + (@raffle.tickets.where(:tier => :silver).count.to_i*2) + (@raffle.tickets.where(:tier => :bronze).count.to_i) 
            @winner = raff_arr.sample
            @raffle.update(winner: @winner)
            #code to ship item to winner using amazon api
            Raffle.create(product_name: @raffle.product_name, product_description: @raffle.product_description, product_image: @raffle.product_image, category: @raffle.category, number_of_ticket_slots: @raffle.number_of_ticket_slots)
          end
         redirect_to edit_raffle_path(@raffle)
        end

      def delete
        params[:filter].clear
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
