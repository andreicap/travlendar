class Event < ApplicationRecord
  validates_uniqueness_of :gid
  belongs_to :user
end
