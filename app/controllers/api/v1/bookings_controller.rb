module Api
  module V1
    class BookingsController < ApplicationController
      def index
        render jsonapi: Booking.where(filter_params), include: included
      end

      def update
        if find_booking.update(params[:_jsonapi][:data][:attributes].permit!)
          schedule_booking_worker
          render jsonapi: find_booking
        else
          render jsonapi_errors: find_booking.errors
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

      def schedule_booking_worker
        number = find_booking.bl_number
        line = find_booking.steamship_line
        BookingWorker.perform_async(number, line) if find_booking.watch?
      end

      def find_booking
        @booking ||= Booking.find(params[:id])
      end

      def service
        @service ||= BookingService.new(crawler, params[:bl_number])
      end

      def crawler
        @crawler ||= Booking.build_crawler(
          params[:bl_number], params[:steamship_line]
        )
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
