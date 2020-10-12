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
      puts "hi"
      puts ticket_create("gold")
      ticket_count("gold").times ticket_create("gold")
      ticket_count("silver").times ticket_create("silver")
      ticket_count("bronze").times ticket_create("bronze")

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
