module Api
  module V1
    class BookingsController < ApplicationController
      def index
        render jsonapi: Booking.where(filter_params), include: included
      end

      def search
        service = BookingService.new(crawler, params[:bl_number])

        if service.valid?
          service.update_booking
          render jsonapi: service.booking, include: included
        else
          render jsonapi_errors: service.errors, status: 422
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

      def included
        %i[containers booking_events]
      end
    end
  end
end
