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

   
end
