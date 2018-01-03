
require "open-uri"

class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to root_path, :alert => "Access denied."
    end
  end

  def getcalendar
    get_google_calendars
    get_events_for_calendar
    redirect_to users_path
  end
 
private

  def get_google_calendars
    url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{current_user.token}"
    response = open(url)
    json = JSON.parse(response.read)
    calendars = json["items"]
    calendars.each { |cal| get_events_for_calendar(cal) }
  end

  def get_events_for_calendar(cal)

    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{current_user.token}"
    response = open(url)
    json = JSON.parse(response.read)
    @my_events = json["items"]

    puts "-------my_events:", my_events, "---------"

    @my_events.each do |event|
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
        calendar: calendar
        )
    end
  end


end
