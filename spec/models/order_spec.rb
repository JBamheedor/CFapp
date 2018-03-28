require 'rails_helper'

describe Order do
  context "Validation testing" do
    let(:user) { User.create!(first_name: "Bike", last_name: "Man", password:"password", email: "Bikeman@mail.com") }
    # let(:order) { Order.create!(product_id: 55) }

    it "should return first name" do
      expect(user.first_name).to eq "Bike"
    end

    it "should return last name" do
      expect(user.last_name).to eq "Man"
    end

    it "Is invalid without product" do
      expect(Order.new(product_id: nil)).not_to be_valid
    end
  end

end
