require 'rails_helper'

describe Board do
  it "has a valid factory" do
    expect(build(:board)).to be_valid
  end

  let(:board) { build(:board) }
  let(:active_board) { create(:active_board) }
  let(:inactive_board) { create(:inactive_board) }

  describe "validations" do
    it { expect(board).to validate_presence_of(:key) }
    it { expect(board).to validate_uniqueness_of(:key) }
    it { expect(board).to validate_presence_of(:title) }
  end

  describe "public instance methods" do
    describe "#to_board_stage_json" do
      it "returns the board and associated child records in json"
    end
  end

  describe "public class methods" do
    describe "#self.is_active_key?" do
      it "returns true if active board exists with the key" do
        key = active_board["key"]
        expect(Board.is_active_key?(key)).to be true
      end

      it "returns false if inactive board exists with the key" do
        key = inactive_board["key"]
        expect(Board.is_active_key?(key)).to be false
      end

      it "returns false for nonexistent key" do
        key = "nonexistent_key"
        expect(Board.is_active_key?(key)).to be false
      end
    end

    describe "#self.is_unique_key?" do
      it "returns true if key isn't already taken" do
        key = "nonexistent_key"
        expect(Board.is_unique_key?(key)).to be true
      end
      it "returns false if key is already taken" do
        key = active_board["key"]
        expect(Board.is_unique_key?(key)).to be false
      end
    end
  end
end
