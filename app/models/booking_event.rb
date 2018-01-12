class BookingEvent < ApplicationRecord
  before_save :normalize_bl_number

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

  private

  def normalize_bl_number
    self.bl_number = Booking.normalized_bl_number(bl_number)
  end
end
