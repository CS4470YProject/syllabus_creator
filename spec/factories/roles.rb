FactoryGirl.define do
  factory :role do


    trait :admin do
      after(:create) do
        role_type :admin
      end
    end

    trait :instructor do
      after(:create) do
        role_type :instructor
      end
    end
  end

end
