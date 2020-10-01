class TicketsController < ApplicationController

    def new
        ticket = Ride.create(user_id: params[:user_id], raffle_id: params[:raffle_id])
        @message = ticket.use_tickets
        redirect_to user_path(current_user, message: @message)
    end

    def create
      Ticket.create(ticket_params)
        if @ticket.save 
            @ticket.cost = @ticket.ticket_cost
        end
    end
end
