require 'rails_helper'

RSpec.describe ElementRule, type: :model do
  describe 'Relationships' do
    it { should belong_to(:element) }
    it { should belong_to(:rule) }
  end
end
