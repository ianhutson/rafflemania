class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:amazon]
         
  has_many :tickets
  has_many :raffles, through: :tickets
  attr_accessor :gold, :silver, :bronze
  
  def password_required?
    super && provider.blank?
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.shipping_name = auth.info.name 
    user.username = auth.info.email
    end
  end

  
end
