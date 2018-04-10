require 'rails_helper'

describe Product do
  # let(:product) { Product.create!(name: "race bike", description: "Great bike does everything", color: "Pink", price: "889") }
  # let(:user) { User.create!(email: "john@bikes.com", password: "ilovebikes", first_name: "User", last_name: "bike", admin: false) }
  before do
    @product = FactoryBot.create(:product)
    @user = FactoryBot.create(:user)
    @product.comments.create!(rating: 1, user: @user, body: "Awful bike!")
    @product.comments.create!(rating: 3, user: @user, body: "OK bike!")
    @product.comments.create!(rating: 5, user: @user, body: "Great bike!")
  end

  context "Testing methods When the product has comments" do

    it "returns the average rating of all comments" do
      expect(@product.average_rating).to eq 3
    end

    it "returns the lowest rating of all comments" do
      expect(@product.lowest_rating_comment.rating).to eq 1
    end

    it "returns the highest rating of all comments" do
      expect(@product.highest_rating_comment.rating).to eq 5
    end
  end

  context "Testing model validations when creating product" do
    it "is not valid without a name" do
      @product = FactoryBot.build(:product, name: nil)
      expect(@product).to_not be_valid
      # expect(Product.new(name: nil, description: "Really nice bike ", color: "blue", price: 999)).not_to be_valid
    end

    it "is not valid without <10 characters" do
      @product = FactoryBot.build(:product, description: "Bike")
      expect(@product).to_not be_valid
      # expect(Product.new(name: "Bike", description: "Nice bike", color: "blue", price: 999)).not_to be_valid
    end

    it "is not valid without an integer" do
      @product = FactoryBot.build(:product, price: 9.99)
      expect(@product).to_not be_valid
      # expect(Product.new(name: "Bike", description: "Really Nice bike", color: "blue", price: 9.99)).not_to be_valid
    end

    it "is not valid without a color" do
      @product = FactoryBot.build(:product, color: nil)
      expect(@product).to_not be_valid
      # expect(Product.new(name: "Bike", description: "Really Nice bike", color: nil, price: 999)).not_to be_valid
    end

    it "is not valid without an image_url" do
      @product = FactoryBot.build(:product, image_url: nil)
      expect(@product).to_not be_valid
    end
  end
end
