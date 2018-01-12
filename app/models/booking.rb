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

  def self.build_crawler(bl_number, steamship_line)
    class_name = "#{steamship_line.camelize}Crawler"
    number = request_bl_number(bl_number)
    class_name.constantize.new(number)
  end

  def watch?
    ActiveModel::Type::Boolean.new.cast(watch)
  end

  private

  def normalize_bl_number
    self.bl_number = self.class.normalized_bl_number(bl_number)
  end
end
