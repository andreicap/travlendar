
require 'open-uri'
require 'rest-client'

class UsersController < ApplicationController
  before_action :authenticate_user!

  # test function to present  all regitestered users
  # will not  be available from production
  def index
    # @users = User.all
    redirect_to root_path
  end

  # test function to present current users
  # will not  be available from production
  def show
    redirect_to root_path # if (!current_user) 
  end

  # main method to return the /calendar page
  # it renders the calendar template which contains the events' list and the map
  def calendar
    render "calendar"
  end

  # update calendar method, accessing the private methods below
  def getcalendar
    # it cleans the current user event list:
    current_user.events.destroy_all
    # fetches a new authentication token:
    refresh_token
    # then gets the calendars and their events
    get_google_calendars
    # redirects user to the calendar view
    redirect_to calendar_path
  end
 
private

  # method to get all google calendars of a authenticated user
  # a the moment it keeps only one calendar: the calendar with the same name as the email
  def get_google_calendars
    url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{current_user.token}"
    response = open(url)
    json = JSON.parse(response.read)
    calendars = json["items"]
    calendars.each do |cal| 
      if cal["id"] == current_user.email
         get_events_for_calendar(cal)
      end
    end
  end

  # method to get all events for a specific calendar
  # currently keeps only 10 events
  def get_events_for_calendar(cal)
    today = Date::today.to_time.rfc3339
    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{current_user.token}"
    response = open(url)
    json = JSON.parse(response.read)
    @my_events = json["items"]
    i = 0
    @my_events.each do |event|
      
      name = event["summary"] || "no name"
      creator = event["creator"] ? event["creator"]["email"] : nil
      start = event["start"] ? event["start"]["dateTime"] : nil
      next if !start
      status = event["status"] || nil
      link = event["htmlLink"] || nil
      calendar = cal["summary"] || nil
      location = event["location"] || nil
      htmlLink = event["htmlLink"] || nil
      endtime = event["end"] ? event["end"]["dateTime"] : nil
      next if endtime < DateTime.now
      gid = event["id"]

      current_user.events.create(
        name: name,
        creator: creator,
        status: status,
        start: start,
        link: link,
        location: location,
        calendar: calendar,
        htmllink: htmlLink,
        end: endtime,
        gid: gid
      )
      i+=1
      break if i == 10
    end
   
  end

  # method to refresh a auth token.
  def refresh_token
    data = {
      :client_id => ENV["GOOGLE_CLIENT_ID"], 
      :client_secret => ENV["GOOGLE_CLIENT_SECRET"],
      :refresh_token => current_user.refresh_token,
      :grant_type => "refresh_token"
    }
    @response = JSON.parse(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    if @response["access_token"].present?
      current_user.token = @response["access_token"]
      current_user.token_expiry = Time.now.utc + @response["expires_in"].to_i.seconds
      current_user.save!
    else
       # Something else bad happened
       #throws an error
    end
  end


end


