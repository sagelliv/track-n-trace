class BookingWorker
  WINDOW = 4.hours
  include Sidekiq::Worker

  def perform(bl_number, steamship_line)
    crawler = build_crawler(bl_number, steamship_line)
    service = BookingService.new(crawler, bl_number)

    ActiveRecord::Base.transaction do
      service.update_booking if service.valid?
      if watching?(bl_number)
        self.class.perform_in(WINDOW, bl_number, steamship_line)
      end
    end
  end

  private

  def watching?(bl_number)
    Booking.find_by(bl_number: bl_number).watch?
  end

  def build_crawler(bl_number, steamship_line)
    class_name = "#{steamship_line.camelize}Crawler"
    number = Booking.request_bl_number(bl_number)
    class_name.constantize.new(number)
  end
end
