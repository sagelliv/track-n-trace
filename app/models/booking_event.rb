class BookingEvent < ApplicationRecord
  belongs_to :booking
  has_many :containers

  validates :bl_number,
            :steamship_line,
            :origin,
            :destination,
            :vessel,
            :voyage,
            :vessel_eta,
            :event_changes,
            presence: true
end
