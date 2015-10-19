require 'rails_helper'

RSpec.describe Outline, type: :model do
  describe 'Relationships' do
    it { should have_many(:outline_elements) }
    it { should have_many(:elements).through(:outline_elements) }
    it { should belong_to(:user) }
  end
end
