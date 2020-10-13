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


    # def self.search(search)
    #     if search
    #         raffle = Raffle.all
    #     else
    #         keys = key.split('+')
    #         Raffle.where((['product_name LIKE ?'] * keys.size).join(' OR '), *keys.map{ |key| "%#{key}%" })
    
    #     end
    # end

end

