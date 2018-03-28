require 'rails_helper'

describe Comment do
  context "Validation testing" do

    it "is invalid without rating" do
      expect(Comment.new(rating:nil)).not_to be_valid
    end
    it "is invalid without user id" do
      expect(Comment.new(user_id:nil)).not_to be_valid
    end
  end
end
