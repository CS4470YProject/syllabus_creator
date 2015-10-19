require 'rails_helper'

RSpec.describe Element, type: :model do
  describe 'Relationships' do
    it { should have_many(:outline_elements) }
  end
end
