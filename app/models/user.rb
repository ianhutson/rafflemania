class User < ApplicationRecord
has_many :tickets
has_many :raffles, through: :tickets
 # before_action :require_login, only: [:show]
validates_uniqueness_of :username, scope: :id, :on => :create
validates :email, 
    :uniqueness => {:message => "email in use", scope: :id, :on => :create},
    :format => { :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :message => "invalid format"}
validates :password_digest, 
:presence => {:message => "should match confirmation", :on => :update},
:confirmation => true, 
:length => {:within => 6..40}, 
:on => :create,
:if => :password_digest


end
