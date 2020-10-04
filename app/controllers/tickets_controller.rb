class TicketsController < ApplicationController
   def new
      @ticket = Ticket.new
      @user = current_user
   end

   def index
        @user = current_user
        @tickets = @user.tickets
   end
  
   def index
      @user = current_user
      @tickets = @user.tickets
   end

   def edit
      @ticket = Ticket.new
      @tickets = current_user.tickets.all
   end

   def create
      params[:ticket][:gold].to_i.times {Ticket.create(:user_id => current_user.id, :tier => 'gold')}
      params[:ticket][:silver].to_i.times {Ticket.create(:user_id => current_user.id, :tier => 'silver')}
      params[:ticket][:bronze].to_i.times {Ticket.create(:user_id => current_user.id, :tier => 'bronze')}

      redirect_to root_url
      puts params
   end
end
