FactoryGirl.define do
  factory :outline do
    course FactoryGirl.create(:course, code: 'cs4499')
  end

  factory :template, parent: :outline, class: 'Template' do
    department
  end

end
