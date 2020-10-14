class Ticket < ApplicationRecord
    belongs_to :user
    belongs_to :raffle, optional: true
    attr_accessor :gold, :silver, :bronze


end
