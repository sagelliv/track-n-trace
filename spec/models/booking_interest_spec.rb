require 'rails_helper'

describe BookingInterest, type: :model do
  subject { build(:booking_interest) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:booking) }

  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:booking) }
end
