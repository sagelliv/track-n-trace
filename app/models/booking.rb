class Booking < ApplicationRecord
  has_many :booking_events
  has_many :containers

  validates :bl_number,
            :steamship_line,
            :origin,
            :destination,
            :vessel,
            :voyage,
            :vessel_eta,
            presence: true
end
