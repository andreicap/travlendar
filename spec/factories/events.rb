FactoryBot.define do
  factory :event do
    before_create do |e|
        FactoryBot.create(:user, event: e)
    end
    name      "test1"
    creator   "capastrua.xd@gmail.com"
    start     "2018-01-08T10:15:00.000Z"
    status    "confirmed"
    link      "https://www.google.com/calendar/event?eid=M3EwNWQ0b2c4NnUxZ3BpOXU4dDM2dXN0MXEgY2FwYXN0cnVhLnhkQG0"
    calendar  "capastrua.xd@gmail.com"
    location  "Bovisa, Milan, Metropolitan City of Milan, Italy"
    user_id   6
  end
end
