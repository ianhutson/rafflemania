class User < ApplicationRecord
has_many :tickets
has_many :raffles, through: :tickets


end
