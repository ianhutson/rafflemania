class TicketsController < ApplicationController
   def new
      @ticket = Ticket.new
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
      @ticket = Ticket.create(:user_id => current_user.id, :tier => 'gold')
      redirect_to root_url
   end
end
