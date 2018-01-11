require 'rails_helper'

describe Container, type: :model do
  subject { build(:container) }

  it { is_expected.to be_valid }

  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to validate_presence_of(:size) }
  it { is_expected.to validate_presence_of(:type) }
end
