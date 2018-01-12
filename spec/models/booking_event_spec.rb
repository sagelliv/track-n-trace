require 'rails_helper'

describe BookingEvent, type: :model do
  subject { build(:booking_event) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:booking) }
  it { is_expected.to have_many(:containers) }

  it { is_expected.to validate_presence_of(:bl_number) }
  it { is_expected.to validate_presence_of(:steamship_line) }
  it { is_expected.to validate_presence_of(:origin) }
  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_presence_of(:vessel) }
  it { is_expected.to validate_presence_of(:voyage) }
  it { is_expected.to validate_presence_of(:vessel_eta) }
  it { is_expected.to validate_presence_of(:event_changes) }

  it 'normalizes without PABV' do
    subject.save

    expect(subject.bl_number[0..3]).to eq('PABV')
  end

  describe '#diff' do
    it 'diffs one attribute' do
      event = build(:booking_event)
      other_event = build(
        :booking_event, booking: event.booking, origin: 'another'
      )

      expect(event.diff(other_event)).to eq('Origin changed')
    end

    it 'diffs multiple attributes' do
      event = build(:booking_event)
      other_event = build(
        :booking_event,
        origin: 'another',
        booking: event.booking,
        destination: 'another-destination'
      )

      expect(event.diff(other_event)).to eq('Origin, destination changed')
    end

    it 'diffs containers attributes' do
      event = create(:booking_event)
      container = create(:container, booking_event: event)
      other_event = create(:booking_event, booking: event.booking)
      create(
        :container,
        size: "25'",
        number: container.number,
        booking_event: other_event
      )

      expect(event.diff(other_event)).to eq('Containers changed')
    end

    it 'diffs containers attributes and its own' do
      event = create(:booking_event)
      container = create(:container, booking_event: event)
      other_event = create(
        :booking_event, origin: 'another', booking: event.booking
      )
      create(
        :container,
        size: "25'",
        number: container.number,
        booking_event: other_event
      )

      expect(event.diff(other_event)).to eq('Containers, origin changed')
    end

    it 'diffs no changes' do
      event = create(:booking_event)
      container = create(:container, booking_event: event)
      other_event = create(:booking_event, booking: event.booking)
      create(
        :container, number: container.number, booking_event: other_event
      )

      expect(event.diff(other_event)).to eq('Nothing changed')
    end

    it 'diffs with bookings and no changes' do
      event = create(:booking_event)
      booking = create(:booking)

      expect(event.diff(booking)).to eq('Nothing changed')
    end

    it 'diffs with bookings with changes' do
      event = create(:booking_event)
      booking = create(:booking, destination: 'destination')

      expect(event.diff(booking)).to eq('Destination changed')
    end
  end
end
