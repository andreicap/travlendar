class Event < ApplicationRecord
  validates_uniqueness_of :gid
  validates_presence_of :creator, :calendar, :location, :start, :user_id
  
  belongs_to :user

end
