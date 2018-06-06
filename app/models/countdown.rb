class Countdown < ApplicationRecord
  mount_uploader :main_image, CountdownMainImageUploader
  mount_uploader :background_image, CountdownBackgroundImageUploader

  belongs_to :user
  validates :name, presence: true, length: { maximum: 150 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  def date_format(format)
    date.strftime(format)
  end

  protected

    def date_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end
end
