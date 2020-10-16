class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:amazon]       
  has_many :tickets
  has_many :raffles, through: :tickets
  attr_accessor :gold, :silver, :bronze

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.shipping_name = auth.info.name 
    user.username = auth.info.email
    end
  end

  # def enough_tickets?
  #   bid_gold > self.user_gold || bid_silver > self.user_silver || bid_bronze > self.user_bronze
  # end

  def user_gold
    self.tickets.all_gold.unused.count
  end

  def user_silver
    self.tickets.all_silver.unused.count 
  end

  def user_bronze
    self.tickets.all_bronze.unused.count 
  end
  
 

end
