class SerializableContainer < JSONAPI::Serializable::Resource
  type :containers

  belongs_to :booking
  belongs_to :booking_event

  attributes :number, :size, :container_type
end
