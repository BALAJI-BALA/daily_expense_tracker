class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :expenses, dependent: :destroy
  has_secure_token :auth_token
  before_save :set_expiration

	def set_expiration
		self.token_expires_at = DateTime.now + 10.minutes
	end
end
