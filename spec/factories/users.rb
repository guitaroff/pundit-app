FactoryGirl.define do
  factory :user do
    email 'test@example.com'
    password 'password'
  end

  trait :admin do
    role 'admin'
  end
end
