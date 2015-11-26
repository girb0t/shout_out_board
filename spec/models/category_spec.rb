require 'rails_helper'

describe Category do
  it "has a valid factory" do
    expect(build(:category)).to be_valid
  end

  let(:category) { build(:category) }

  describe "validations" do
    it { expect(category).to validate_presence_of(:title) }
    it { expect(category).to validate_presence_of(:prompt) }
  end
end
