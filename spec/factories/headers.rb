FactoryGirl.define do
  factory :header do
    text Faker::Lorem.sentence(5)
    size 24
  end
end