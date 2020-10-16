class Raffle < ApplicationRecord
    has_many :tickets
    has_many :users, through: :tickets
    attr_accessor :gold, :silver, :bronze

    def self.filter(filter)
        if filter
            raffle = Raffle.where(category: filter)
        else
            Raffle.all
        end
    end

    # def bid_tickets(tier)
    #     params[:raffle][:"tier"].to_i
    # end
    
    # def bid_total
    #     (bid_tickets(gold) * 3) + (bid_tickets(silver) * 2) + bid_tickets(bronze)
    # end

    def current_bids
        (self.tickets.all_gold.count*3) + (self.tickets.all_silver.count*2) + (self.tickets.all_bronze.count)
    end

    def enough_slots?
        bid_total + current_bids > self.number_of_ticket_slots 
    end
  
    def current_tickets(user, tier)
        user.tickets.where(tier: tier, raffle_id: self.id).count
    end

    def update_tickets(user, gold, silver, bronze)
        gold.times {user.tickets.find_by(tier: 'gold', used: false).update(:used => true, :raffle_id => self.id)}
        silver.times {user.tickets.find_by(tier: 'silver', used: false).update(:used => true, :raffle_id => self.id)}
        bronze.times {user.tickets.find_by(tier: 'bronze', used: false).update(:used => true, :raffle_id => self.id)}
        @@raff_arr = []
        @@raff_arr.fill(user.username, @@raff_arr.size, gold*3)
        @@raff_arr.fill(user.username, @@raff_arr.size, silver*2)
        @@raff_arr.fill(user.username, @@raff_arr.size, bronze )
    end

    def enough_slots?
        bid_total + current_bids > self.number_of_ticket_slots 
    end

    def slots_filled?
        self.number_of_ticket_slots == current_bids
    end

    def select_winner
        @winner = @@raff_arr.sample
        self.update(winner: @winner)
       #code to ship item to winner using amazon api
       Raffle.create(product_name: self.product_name, product_description: self.product_description, product_image: self.product_image, category: self.category, number_of_ticket_slots: self.number_of_ticket_slots)
    end

end

