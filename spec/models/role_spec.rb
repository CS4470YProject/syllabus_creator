require 'rails_helper'

RSpec.describe Role, type: :model do
  describe 'Relationships' do
    it { should have_many(:user_roles) }
  end
end
