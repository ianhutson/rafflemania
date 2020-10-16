class Ticket < ApplicationRecord
    belongs_to :user
    belongs_to :raffle, optional: true
    attr_accessor :gold, :silver, :bronze
    scope :gold, -> { find_by(tier: 'gold') }
    scope :silver, -> { find_by(tier: 'silver') }
    scope :bronze, -> { find_by(tier: 'bronze') }
    scope :unused, -> { where(used: false)}
    scope :all_gold, -> { where(tier: 'gold') }
    scope :all_silver, -> { where(tier: 'silver') }
    scope :all_bronze, -> { where(tier: 'bronze') }
end
