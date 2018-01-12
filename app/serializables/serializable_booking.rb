class SerializableBooking < JSONAPI::Serializable::Resource
  type :bookings

  attributes :bl_number, :steamship_line, :origin, :destination, :vessel,
             :voyage, :watch

  attribute :vessel_eta do
    @object.vessel_eta.strftime('%Y-%m-%d')
  end

  has_many :containers
  has_many :booking_events
end
