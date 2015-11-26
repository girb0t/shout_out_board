require 'rails_helper'

describe Board do
  it "has a valid factory" do
    expect(build(:board)).to be_valid
    expect(build(:active_board)).to be_valid
    expect(build(:inactive_board)).to be_valid
  end

  let(:board) { build(:board) }

  describe "validations" do
    it { expect(board).to validate_presence_of(:key) }
    it { expect(board).to validate_presence_of(:title) }
  end

  describe "public instance methods" do
    describe "#to_board_stage_json" do
      it "returns the board and associated child records in json"
    end
  end

  describe "public class methods" do
    describe "#self.is_active_key?" do
      it "returns true for active key"
      it "returns false for inactive key"
      it "returns false for nonexistent key"
    end

    describe "#self.is_unique_key?" do
      it "returns true if key isn't already taken"
      it "returns false if key is already taken"
    end
  end
end
