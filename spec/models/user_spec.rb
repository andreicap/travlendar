require 'rails_helper'

RSpec.describe User, type: :model do
  
  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryBot.create(:user)).to be_valid
    end
  end

  describe 'Associations' do
    it 'validates relation to events' do
      should have_many :events
    end
    
  end

  
end
