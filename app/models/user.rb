class User < ApplicationRecord
has_many :tickets
has_many :raffles, through: :tickets
has_secure_password


end
