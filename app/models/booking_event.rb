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

  def diff(other_event)
    all_changes = (
      container_changes(other_event) +
      changed_attrs(attributes, other_event.attributes)
    ).join(', ').capitalize
    all_changes = 'Nothing' if all_changes.empty?

    "#{all_changes} changed"
  end

  private

  def changed_attrs(attributes, other_attributes)
    (attributes.to_a - other_attributes.to_a)
      .map(&:first).map(&:to_sym) - default_attrs
  end

  def container_changes(other_event)
    container_changes = containers.any? do |container|
      changed_attrs(
        container.attributes,
        other_event.containers.find_by(number: container.number).attributes
      ).present?
    end

    container_changes ? ['Containers'] : []
  end

  def normalize_bl_number
    self.bl_number = Booking.normalized_bl_number(bl_number)
  end

  def default_attrs
    %i[id created_at updated_at booking_event_id booking_id event_changes]
  end
end
