require 'rails_helper'

describe Booking, type: :model do
  subject { build(:booking) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:booking_events) }
  it { is_expected.to have_many(:containers) }

  it { is_expected.to validate_presence_of(:bl_number) }
  it { is_expected.to validate_presence_of(:steamship_line) }
  it { is_expected.to validate_presence_of(:origin) }
  it { is_expected.to validate_presence_of(:destination) }
  it { is_expected.to validate_presence_of(:vessel) }
  it { is_expected.to validate_presence_of(:voyage) }
  it { is_expected.to validate_presence_of(:vessel_eta) }

  it 'normalizes without PABV' do
    subject.save!

    expect(subject.bl_number[0..3]).to eq('PABV')
  end

  it 'does not raise error if the bl_number is too short' do
    subject.bl_number = 'short'
    subject.save!

    expect(subject.bl_number[0..3]).to eq('PABV')
  end

  it 'no-ops if PABV prefix exists' do
    bl_number = 'PABVnumber'
    subject.bl_number = bl_number
    subject.save!

    expect(subject.bl_number).to eq(bl_number)
  end

  describe ':normalized_bl_number' do
    it 'adds the PABV prefix' do
      number = 'non-prefixed'
      normalized = described_class.normalized_bl_number(number)

      expect(normalized).to eq('PABV' + number)
    end

    it 'does not change a normalized number' do
      number = 'PABV-prefixed'
      normalized = described_class.normalized_bl_number(number)

      expect(normalized).to eq(number)
    end
  end

  describe ':request_bl_number' do
    it 'removes PABV prefix' do
      number = 'PABV-prefixed'
      normalized = described_class.request_bl_number(number)

      expect(normalized).to eq('-prefixed')
    end

    it 'does not change if PABV prefix is not present' do
      number = 'unprefixed'
      normalized = described_class.request_bl_number(number)

      expect(normalized).to eq(number)
    end
  end
end
