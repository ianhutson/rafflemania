class Ticket < ApplicationRecord
    belongs_to :user
    belongs_to :raffle, optional: true
    attr_accessor :gold, :silver, :bronze

    @@cost = {"bronze" => 1, "silver" => 2, "gold": 3} 

    def cost
        puts "hi"
        puts @@cost[self.tier]
        @@cost[self.tier]
    end 

end
