class Container < ApplicationRecord
  belongs_to :booking, optional: true
  belongs_to :booking_event, optional: true

  validates :number, :size, :container_type, presence: true
end
