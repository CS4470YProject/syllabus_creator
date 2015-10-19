require 'rails_helper'

RSpec.describe OutlineElement, type: :model do
  describe 'Relationships' do
    it { should belong_to(:outline) }
    it { should belong_to(:element) }
  end
end
