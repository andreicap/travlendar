class Event < ApplicationRecord
  # an event should have a unique google identifier
  validates_uniqueness_of :gid

  # an event cannot be processed without these attributes:
  validates_presence_of :creator, :calendar, :location, :start, :user_id
  
  # association with a user, to avoid ghost events in the database
  belongs_to :user
end
