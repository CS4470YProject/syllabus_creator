require 'rails_helper'

RSpec.describe Category, type: :model do
  describe 'Relationships' do
    it { should have_many(:templates) }
  end
end
