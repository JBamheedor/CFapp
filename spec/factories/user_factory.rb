FactoryBot.define do
  sequence(:email) { |n| "user#{n}@example.co.uk" }

  factory :user do
    email
    password "1234567890"
    first_name "John"
    last_name "Example"
    admin false
  end

  factory :admin, class: User do
    email
    password "qwertyuiop"
    admin true
    first_name "Admin"
    last_name "User"
end
end
