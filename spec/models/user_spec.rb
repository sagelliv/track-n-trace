require 'rails_helper'

describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
end
