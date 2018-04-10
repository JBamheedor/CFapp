FactoryBot.define do
  #generate values with a specific format using sequences
  #This creates random number between 1 and 5
  sequence(:rating) { rand(1..5)}
  sequence(:body) { |n| "Test comment number #: #{n}" }

  factory :comment do
    association :product, factory: :product
    association :user, factory: :user
    body
    rating
  end
end
