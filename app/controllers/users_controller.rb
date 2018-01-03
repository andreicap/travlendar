
require 'open-uri'
require 'rest-client'

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

  def calendar
    
  end

  def getcalendar
    refresh_token
    get_google_calendars
    redirect_to calendar_path
  end
 
private

  def get_google_calendars

    url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{current_user.token}"
    response = open(url)
    json = JSON.parse(response.read)
    calendars = json["items"]
    # puts "--------calendars:"
    # pp calendars
    calendars.each do |cal| 
      if cal["id"] == current_user.email
         get_events_for_calendar(cal)
      end
    end
  end

  def get_events_for_calendar(cal)
    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{current_user.token}"
    # puts "------url:", url, "-------"
    response = open(url)
    json = JSON.parse(response.read)
    @my_events = json["items"]

    # puts "-------my_events:", @my_events, "---------"

    @my_events.each do |event|
      name = event["summary"] || "no name"
      creator = event["creator"] ? event["creator"]["email"] : nil
      start = event["start"] ? event["start"]["dateTime"] : nil
      status = event["status"] || nil
      link = event["htmlLink"] || nil
      calendar = cal["summary"] || nil
      location = event["location"] || nil
      htmlLink = event["htmlLink"] || nil
      endtime = event["end"] ? event["end"]["dateTime"] : nil
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
    end
  end

  def refresh_token
    data = {
      :client_id => ENV["GOOGLE_CLIENT_ID"], 
      :client_secret => ENV["GOOGLE_CLIENT_SECRET"],
      :refresh_token => current_user.refresh_token,
      :grant_type => "refresh_token"
    }
    @response = JSON.parse(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    puts "-----response:"
    pp @response
    if @response["access_token"].present?
      current_user.token = @response["access_token"]
      current_user.token_expiry = Time.now.utc + @response["expires_in"].to_i.seconds
      current_user.save!
    else
       # Something else bad happened
    end
  end


end


