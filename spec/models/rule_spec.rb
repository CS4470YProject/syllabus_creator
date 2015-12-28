require 'rails_helper'

RSpec.describe Rule, type: :model do
  describe 'Relationships' do
    it { should have_many(:element_rules) }
  end
end
