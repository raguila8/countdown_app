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
  validates :bio, length: { maximum: 500 }
  validates :name, length: { maximum: 70 }

  #validate :profile_image_size

  private

    # Validates the size of an uploaded image
		def profile_image_size
			if self.profile_image.size > 5.megabytes
				errors.add(:profile_image, "should be less than 5MB")
			end
		end

end
