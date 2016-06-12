require 'rails_helper'

describe User do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  let(:user) { build(:user) }

  describe "validations" do
    it { expect(user).to validate_presence_of(:first_name) }
    it { expect(user).to validate_presence_of(:last_name) }
    it { expect(user).to validate_presence_of(:username) }
    it { expect(user).to validate_uniqueness_of(:username) }
  end
end

