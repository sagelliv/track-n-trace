require 'rails_helper'

describe BookingService do
  describe '#update_booking if bl_number does not exist' do
    it 'adds booking' do
      service = described_class.new(build_crawler, 'number')

      expect { service.update_booking }.to change { Booking.count }.by(1)
    end

    it 'adds booking event' do
      service = described_class.new(build_crawler, 'number')

      expect { service.update_booking }.to change { BookingEvent.count }.by(1)
    end

    it 'adds containers' do
      service = described_class.new(build_crawler, 'number')

      expect { service.update_booking }.to change { Container.count }.by(2)
    end
  end

  describe '#update_booking if bl_number exists' do
    it 'adds a booking' do
      bl_number = 'number'
      create(:booking, bl_number: bl_number)
      service = described_class.new(build_crawler, bl_number)

      expect { service.update_booking }.to change { Booking.count }.by(0)
    end

    it 'adds a booking event' do
      bl_number = 'number'
      create(:booking, bl_number: bl_number)
      service = described_class.new(build_crawler, bl_number)

      expect { service.update_booking }.to change { BookingEvent.count }.by(1)
    end

    it 'adds containers' do
      bl_number = 'number'
      create(:booking, bl_number: bl_number)
      service = described_class.new(build_crawler, bl_number)

      expect { service.update_booking }.to change { Container.count }.by(2)
    end

    it 'updates the booking' do
      bl_number = 'number'
      booking = create(:booking, origin: 'origin', bl_number: bl_number)
      create(:booking_event, booking: booking)
      service = described_class.new(build_crawler, bl_number)

      expect(service.booking.origin).to eq('Xingang')
    end

    it "updates the booking's containers" do
      bl_number = 'number'
      booking = create(:booking, origin: 'origin', bl_number: bl_number)
      create(:container, size: "30'", booking: booking)
      service = described_class.new(build_crawler, bl_number)

      service.update_booking

      expect(service.booking.containers.reload.first.size).to eq("20'")
    end
  end

  describe '#update_booking booking changes' do
    it 'reflect diffs' do
      bl_number = 'PABVnumber'
      booking = create(:booking, bl_number: bl_number)
      create(:booking_event,
             origin: 'another',
             booking: booking,
             bl_number: bl_number)
      service = described_class.new(build_crawler, bl_number)

      service.update_booking

      event = BookingEvent.order(created_at: :asc).last
      expect(event.event_changes).to eq('Origin changed')
    end
  end
end

def build_crawler(opts = {})
  CrawlerStub.new(opts)
end

class CrawlerStub
  def initialize(opts = {})
    @opts = opts
    @opts[:is_valid] ||= true
    @opts[:bl_number] ||= 'PABVnumber'
  end

  def valid?
    @opts[:is_valid]
  end

  def extracted_attrs
    {
      booking: {
        bl_number: @opts[:bl_number], steamship_line: 'pil', origin: 'Xingang',
        destination: 'Oakland', vessel: 'CSCL AUTUMN', voyage: 'VQC60007E',
        vessel_eta: Date.new(2017, 4, 19)
      },
      containers: [
        { size: "20'", container_type: 'GP', number: 'PCIU1857050' }
      ]
    }
  end
end
