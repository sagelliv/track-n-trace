module Api
  module V1
    class BookingsController < ApplicationController
      def index
        render jsonapi: Booking.where(params[:filter].permit!),
          include: [:containers]
      end

      def search
        # render jsonapi: Booking.last, include: [:containers]
        # return

        attrs = crawler.extracted_attrs
        booking = Booking.create!(attrs[:booking])
        event = BookingEvent.create!(attrs[:booking].merge(
          event_changes: 'None', booking: booking))
        attrs[:containers].each do |container_attrs|
          Container.create!(container_attrs.merge(booking: booking))
          Container.create!(container_attrs.merge(booking_event: event))
        end
        render jsonapi: booking, include: [:containers]

      end

      private

      def crawler
        class_name = "#{params[:steamship_line].camelize}Crawler"
        class_name.constantize.new(params[:bl_number])
      end
    end
  end
end
