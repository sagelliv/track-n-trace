module Api
  module V1
    class BookingsController < ApplicationController
      def index
        render jsonapi: Booking.where(filter_params), include: included
      end

      def update
        booking = find_booking
        if booking.update(params[:_jsonapi][:data][:attributes].permit!)
          schedule_booking_worker(booking)
          render jsonapi: booking
        else
          render jsonapi_errors: booking.errors
        end
      end

      def search
        if service.valid?
          service.update_booking
          render jsonapi: service.booking, include: included
        else
          render jsonapi_errors: service.errors, status: 422
        end
      end

      private

      def schedule_booking_worker(booking)
        number = booking.bl_number
        line = booking.steamship_line
        BookingWorker.perform_async(number, line) if booking.watch?
      end

      def find_booking
        @booking ||= Booking.find(params[:id])
      end

      def service
        @service ||= BookingService.new(crawler, params[:bl_number])
      end

      def crawler
        class_name = "#{params[:steamship_line].camelize}Crawler"
        bl_number = Booking.request_bl_number(params[:bl_number])
        @crawler ||= class_name.constantize.new(bl_number)
      end

      def filter_params
        params[:filter][:bl_number] = Booking.normalized_bl_number(
          params[:filter][:bl_number]
        )
        params[:filter].permit!
      end

      def included
        %i[containers booking_events]
      end
    end
  end
end
