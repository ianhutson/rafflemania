class Ticket < ApplicationRecord
    belongs_to :user
    belongs_to :raffle

    @@ticket_cost = {bronze: 5, silver: 10, gold: 15} 
   
    def ticket_cost 
        @@ticket_cost[self.tier]
    end 

    def use_tickets
        if !enough_tickets?
            "Sorry. You do not have enough tickets to bid on #{self.raffle.product_name}."
        else
            self.user.tickets = self.user.tickets - self.attraction.tickets
            self.user.save
            "Thanks for entering the auction for #{self.raffle.product_name}!"
        end
    end

    private
    
    def enough_tickets?
        raffle.tickets < user.tickets
    end
end
