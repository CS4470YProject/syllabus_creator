require 'rails_helper'

RSpec.describe Department, type: :model do
  describe 'Relationships' do
    it { should have_many(:templates) }
  end
end
