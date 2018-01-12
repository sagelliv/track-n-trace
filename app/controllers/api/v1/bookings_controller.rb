module Api
  module V1
    class BookingsController < ApplicationController
      def index
        render jsonapi: Booking.where(filter_params),
          include: [:containers]
      end

      def search
        if crawler.valid?
          attrs = crawler.extracted_attrs
          booking = Booking.create!(attrs[:booking])
          event = BookingEvent.create!(attrs[:booking].merge(
            event_changes: 'None', booking: booking))
          attrs[:containers].each do |container_attrs|
            Container.create!(container_attrs.merge(booking: booking))
            Container.create!(container_attrs.merge(booking_event: event))
          end
          render jsonapi: booking, include: [:containers]
        else
          render jsonapi_errors: crawler.errors, status: 422
        end
      end

      private

      def filter_params
        params[:filter][:bl_number] = Booking.normalized_bl_number(
          params[:filter][:bl_number]
        )
        params[:filter].permit!
      end

      def crawler
        class_name = "#{params[:steamship_line].camelize}Crawler"
        bl_number = Booking.request_bl_number(params[:bl_number])
        @crawler ||= class_name.constantize.new(bl_number)
      end
    end
  end
end
