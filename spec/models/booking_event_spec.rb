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
    subject.save!

    expect(subject.bl_number[0..3]).to eq('PABV')
  end
end
