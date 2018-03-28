require 'rails_helper'

describe User do
  context "Validation testing" do

    it "is invalid without Email" do
      expect(User.new(first_name: "Bike", last_name: "Man", email: nil, password: "fff")).not_to be_valid
    end
  end
end
