class BookingService
  delegate :valid?, :errors, to: :@crawler

  def initialize(crawler, bl_number)
    @crawler = crawler
    @bl_number = Booking.normalized_bl_number(bl_number)
    @booking_exists = Booking.exists?(bl_number: @bl_number)
  end

  def update_booking
    find_or_create_booking
    create_event
    create_containers
  end

  def booking
    find_or_create_booking
  end

  private

  def find_or_create_booking
    return @booking if @booking

    if @booking_exists
      booking = Booking.find_by(bl_number: @bl_number)
      booking.update!(attrs[:booking])
    else
      booking = Booking.create!(attrs[:booking])
    end
    @booking = booking
  end

  def create_event
    return @event if @event
    previous = previous_event
    @event = BookingEvent.create(
      attrs[:booking].merge(booking: @booking, event_changes: 'First tracking')
    )
    @event.event_changes = @event.diff(previous) if previous
    @event.save!
  end

  def create_containers
    @booking.containers = []
    @booking.save!

    attrs[:containers].each do |attrs|
      Container.create!(attrs.merge(booking: @booking))
      Container.create!(attrs.merge(booking_event: @event))
    end
  end

  def previous_event
    @last_event ||= @booking.booking_events.order(created_at: :asc).last
  end

  def attrs
    @attrs ||= @crawler.extracted_attrs
  end
end
