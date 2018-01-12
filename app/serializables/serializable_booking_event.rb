class SerializableBookingEvent < JSONAPI::Serializable::Resource
  type :booking_events

  attributes :event_changes

  attribute :created_at do
    @object.created_at.strftime('%Y-%m-%d %H:%M')
  end

  belongs_to :booking
end
