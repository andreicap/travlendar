class Calendar < ApplicationRecord
  # has_many :events #calendar belogns to user, a calendar can have many events
  belongs_to :user, dependent: :destroy

  def get_google_calendars
    url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{token}"
    response = open(url)
    json = JSON.parse(response.read)
    calendars = json["items"]
    calendars.each { |cal| get_events_for_calendar(cal) }
  end

  def get_events_for_calendar(cal)
    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{token}"
    response = open(url)
    json = JSON.parse(response.read)
    my_events = json["items"]

    my_events.each do |event|
      name = event["summary"] || "no name"
      creator = event["creator"] ? event["creator"]["email"] : nil
      start = event["start"] ? event["start"]["dateTime"] : nil
      status = event["status"] || nil
      link = event["htmlLink"] || nil
      calendar = cal["summary"] || nil

      events.create(name: name,
        creator: creator,
        status: status,
        start: start,
        link: link,
        calendar: calendar)
    end
  end

end