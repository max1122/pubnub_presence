class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :pubnub

  validates :email,
            presence:   true,
            uniqueness: true

  before_save :set_uuid

  def set_uuid

  	self.pubnub = 4
  end

end
