class SerializableBookingEvent < JSONAPI::Serializable::Resource
  type :booking_events

  attributes :event_changes, :created_at

  belongs_to :booking
end
