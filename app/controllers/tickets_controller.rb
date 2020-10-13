class TicketsController < ApplicationController
   def new
      @ticket = Ticket.new
      @user = current_user
   end

   def index
        @user = current_user
        @tickets = @user.tickets
   end

   def edit
      @ticket = Ticket.new
      @tickets = current_user.tickets.all
   end

   def update
      params[:user][:gold].to_i.times {Ticket.create(:user_id => current_user.id, :tier => 'gold', :used => false)}
      params[:user][:silver].to_i.times {Ticket.create(:user_id => current_user.id, :tier => 'silver', :used => false)}
      params[:user][:bronze].to_i.times {Ticket.create(:user_id => current_user.id, :tier => 'bronze', :used => false)}
      redirect_to root_url
   end
   
   def ticket_count(tier)
      params[:ticket][tier].to_i
   end

   def ticket_create(tier)
      @tier = tier
      Ticket.create(:user_id => current_user.id, :tier => @tier, :used => false)
   end

   
end
