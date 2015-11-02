require 'rails_helper'

RSpec.describe Course, type: :model do
  describe 'Relationships' do
    it { should have_many(:outlines) }
  end
end
