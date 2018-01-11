class SerializableContainer < JSONAPI::Serializable::Resource
  type :containers

  attributes :number, :size, :container_type
end
