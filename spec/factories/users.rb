FactoryGirl.define do
  factory :user do
    first_name 'first'
    last_name 'last'
    email Faker::Internet.email
    password 'password'

    trait :admin do
      after(:create) do |user|
        user.roles << FactoryGirl.create(:role, role_type: 'admin')
      end
    end

    trait :instructor do
      after(:create) do |user|
        user.roles << FactoryGirl.create(:role, role_type: 'instructor')
      end
    end
  end

end
