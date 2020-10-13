class Ticket < ApplicationRecord
    belongs_to :user
    belongs_to :raffle, optional: true
    attr_accessor :gold, :silver, :bronze

    def cost
        @cost = {"bronze" => 1, "silver" => 2, "gold": 3} 
        @cost[self.tier]
    end 

end
