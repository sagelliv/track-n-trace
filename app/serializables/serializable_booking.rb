class SerializableBooking < JSONAPI::Serializable::Resource
  type :bookings

  attributes :bl_number, :steamship_line, :origin, :destination, :vessel,
             :voyage, :vessel_eta, :watch

  has_many :containers
  has_many :booking_events
end
