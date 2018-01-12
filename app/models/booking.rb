class Booking < ApplicationRecord
  PREFIX = 'PABV'.freeze
  before_save :normalize_bl_number

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

  def self.request_bl_number(number)
    number[0..3] == PREFIX ? number[4..-1] : number
  end

  def self.normalized_bl_number(number)
    number[0..3] == PREFIX ? number : PREFIX + number
  end

  private

  def normalize_bl_number
    self.bl_number = self.class.normalized_bl_number(bl_number)
  end
end
