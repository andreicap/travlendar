class Event < ApplicationRecord
  belongs_to :calendar #calendar belogns to user, a calendar can have many events
  
end
