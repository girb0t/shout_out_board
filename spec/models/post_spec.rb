require 'rails_helper'

describe Post do
  it "has a valid factory" do
    expect(build(:post)).to be_valid
  end

  let(:post) { build(:post) }

  describe "validations" do
    it { expect(post).to validate_presence_of(:body) }
  end
end
