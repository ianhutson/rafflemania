module RafflesHelper   

    def current_bids(raffle)
        (Ticket.where(:raffle_id => raffle.id, :tier => "gold").count*3) + (Ticket.where(:raffle_id => raffle.id, :tier => "silver").count*2) + (Ticket.where(:raffle_id => raffle.id, :tier => "bronze").count)
    end

    def current_tickets(user, tier, raffle)
        user.tickets.where(tier: tier, raffle_id: raffle.id).count
    end

    def bid_total
        (bid_gold * 3) + (bid_silver * 2) + bid_bronze
    end
  
    def bid_gold
        params[:raffle][:gold].to_i
    end
  
    def bid_silver
        params[:raffle][:silver].to_i
    end
  
    def bid_bronze
        params[:raffle][:bronze].to_i
    end

    def user_gold(user)
        Ticket.where(:user_id => user.id, :tier => :gold).count.to_i
    end
    
    def user_silver(user)
        Ticket.where(:user_id => user.id, :tier => :silver).count.to_i
    end
    
    def user_bronze(user)
        Ticket.where(:user_id => user.id, :tier => :bronze).count.to_i
    end

    def update_tickets(raffle)
        bid_gold.times {current_user.tickets.find_by(tier: 'gold', used: false).update(:used => true, :raffle_id => raffle.id)}
        bid_silver.times {current_user.tickets.find_by(tier: 'silver', used: false).update(:used => true, :raffle_id => raffle.id)}
        bid_bronze.times {current_user.tickets.find_by(tier: 'bronze', used: false).update(:used => true, :raffle_id => raffle.id)}
        @@raff_arr = []
        @@raff_arr.fill(current_user.username, @@raff_arr.size, bid_gold*3)
        @@raff_arr.fill(current_user.username, @@raff_arr.size, bid_silver*2)
        @@raff_arr.fill(current_user.username, @@raff_arr.size, bid_bronze )
    end

    def enough_slots?(raffle)
        bid_total + current_bids(raffle) > raffle.number_of_ticket_slots 
    end

    def enough_tickets?(user)
        bid_gold > user_gold(user) || bid_silver > user_silver(user) || bid_bronze > user_bronze(user)
    end

    def slots_filled?(raffle)
        raffle.number_of_ticket_slots == current_bids(raffle) 
    end

    def select_winner(raffle)
        @winner = @@raff_arr.sample
        raffle.update(winner: @winner)
       #code to ship item to winner using amazon api
       Raffle.create(product_name: raffle.product_name, product_description: raffle.product_description, product_image: raffle.product_image, category: raffle.category, number_of_ticket_slots: raffle.number_of_ticket_slots)
    end


end
