require 'rails_helper'

describe Comment do
  context "Validation testing" do

  before do
    @comment = FactoryBot.create(:comment)
  end

    it "is valid with numerical rating" do
      @comment = FactoryBot.build(:comment, rating: 3)
      expect(@comment).to be_valid
      # expect(Comment.new(rating: 3)).to be_valid
    end

    it "is invalid without user id" do
      @comment = FactoryBot.build(:comment, user_id:nil)
      expect(@comment).not_to be_valid
      # expect(Comment.new(user_id:nil)).not_to be_valid
    end

    it "is invalid without product id" do
      @comment = FactoryBot.build(:comment, product_id:nil)
      expect(@comment).not_to be_valid
      # expect(Comment.new(product_id:nil)).not_to be_valid
    end

    it "is invalid without comment body" do
      @comment = FactoryBot.build(:comment, body:nil)
      expect(@comment).not_to be_valid
      # expect(Comment.new(body:nil)).not_to be_valid
    end
  end
end
