class Raffle < ApplicationRecord
    has_many :tickets
    has_many :users, through: :tickets
    attr_accessor :gold, :silver, :bronze, :ticket_count
    
    def self.filter(filter)
        if filter
            raffle = Raffle.where(category: filter)
        else
            Raffle.all
        end
    end
    

    def ticket_count
        count = []
        Ticket.where(:raffle_id => self.id).each do |ticket|
            count << ticket.cost.to_i
        end
        return count.sum
    end

    # Set raffle filter

    def set_gold
        [:raffle][:gold].to_i
      end
  
      def set_silver
        [:raffle][:silver].to_i
      end
  
      def set bronze
        [:raffle][:bronze].to_i
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

