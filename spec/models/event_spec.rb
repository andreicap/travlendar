require 'rails_helper'

RSpec.describe Event, type: :model do
   
  context "valid Factory" do
    it "has a valid factory but no user" do
      expect(FactoryBot.create(:event)).to_not be_valid
    end
  end

  context "blank event creation should not be allowed" do
    it "is not valid without a title" do
      event = Event.new()
      expect(event).to_not be_valid
    end
  end


  describe 'validate presence of' do
    it 'event assertion' do
    
    end
  end

  
end
