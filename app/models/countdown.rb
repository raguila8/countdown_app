class Countdown < ApplicationRecord
  mount_uploader :countdown_main_image, ImageUploader
  mount_uploader :countdown_background_image, ImageUploader

  validates :name, presence: true, length: { maximum: 150 }
  validates :date, presence: true
  validate :date_cannot_be_in_the_past

  protected

    def date_cannot_be_in_the_past
      if date.present? && date < Date.today
        errors.add(:date, "can't be in the past")
      end
    end
end
