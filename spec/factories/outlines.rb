FactoryGirl.define do
  factory :outline do
    course
  end

  factory :template, parent: :outline, class: 'Template' do
    department
    course nil
  end

end
