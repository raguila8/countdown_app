class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  before_save { self.email = email.downcase }
  validates :username, presence: true, length: { minimum: 5, maximum: 18 },
											uniqueness: true
  validates :email, presence: true, length: { maximum: 255 },
										uniqueness: { case_sensitive: false }
end
