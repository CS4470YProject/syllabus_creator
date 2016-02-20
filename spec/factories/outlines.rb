FactoryGirl.define do
  factory :outline do
    course
  end

  factory :template, parent: :outline, class: 'Template' do
    category
    course nil
  end

end
