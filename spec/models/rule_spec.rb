require 'rails_helper'

RSpec.describe Rule, type: :model do
  it { should have_many(:element_rules) }
end
