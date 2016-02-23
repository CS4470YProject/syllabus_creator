require 'rails_helper'

RSpec.describe Element, type: :model do
  describe 'Relationships' do
    it { should have_many(:outline_elements) }
    it { should have_many(:element_rules) }
    it { should have_many(:rules) }
    it { should have_many(:rules) }
  end
end
