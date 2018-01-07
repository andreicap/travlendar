require 'rails_helper'

RSpec.describe Event, type: :model do

  context "valid Factory" do
    it "has a valid factory" do
      expect(FactoryBot.create(:event)).to be_valid
    end
  end

  context "blank event creation should not be allowed" do
    it "not valid withoud attributes" do
      event = Event.new()
      expect(event).to_not be_valid
    end
  end

  describe 'Presence' do
    it 'event creator nil' do
      expect(Event.new(creator: nil)).to_not be_valid
    end

    it 'event calendar nil' do
      expect(Event.new(creator: nil)).to_not be_valid
    end

    it 'event location nil' do
      expect(Event.new(creator: nil)).to_not be_valid
    end

    it 'event start nil' do
      expect(Event.new(creator: nil)).to_not be_valid
    end

    it 'event user_id nil' do
      expect(Event.new(creator: nil)).to_not be_valid
    end

    it 'event user' do
      expect(Event.new(user: nil)).to_not be_valid
    end
  end

  describe 'Associations' do
    it "validates belonging to user model" do 
      should belong_to :user
    end
  end

  describe 'Uniqueness' do
    it "validates uniqueness of gid attribute" do 
      should validate_uniqueness_of :gid
    end
  end
  
end
