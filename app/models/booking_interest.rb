class BookingInterest < ApplicationRecord
  belongs_to :user
  belongs_to :booking

  validates :user, :booking, presence: true
end
