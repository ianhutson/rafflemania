class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, :omniauth_providers => [:amazon]
has_many :tickets
has_many :raffles, through: :tickets

# validates_uniqueness_of :username, scope: :id, :on => :create
# # validates :email, format: URI::MailTo::EMAIL_REGEXP
# validates :email, :uniqueness => {:message => "email in use", scope: :id, :on => :create}
# validates :password_digest, 
# :presence => {:message => "should match confirmation", :on => :update},
# :confirmation => true, 
# :length => {:within => 6..40}, 
# :on => :create,
# :on => :new,
# :if => :password_digest

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    user.email = auth.info.email
    user.password = Devise.friendly_token[0, 20]
    user.shipping_name = auth.info.name # assuming the user model has a name
    end
  end
end
