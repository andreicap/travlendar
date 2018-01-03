
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
    redirect_to users_path
  end
 
private

  def get_google_calendars

    url = "https://www.googleapis.com/calendar/v3/users/me/calendarList?access_token=#{current_user.token}"
    response = open(url)
    json = JSON.parse(response.read)
    calendars = json["items"]
    puts "--------calendars:"
    pp calendars
    calendars.each do |cal| 
      if cal["id"] == current_user.email
         get_events_for_calendar(cal)
      end
    end
  end

  def get_events_for_calendar(cal)
    url = "https://www.googleapis.com/calendar/v3/calendars/#{cal["id"]}/events?access_token=#{current_user.token}"
    puts "------url:", url, "-------"
    response = open(url)
    json = JSON.parse(response.read)
    @my_events = json["items"]

    puts "-------my_events:", @my_events, "---------"

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
      :client_id => GOOGLE_APP_KEY,
      :client_secret => GOOGLE_APP_SECRET,
      :refresh_token => self.oauth2_refresh_token,
      :grant_type => "refresh_token"
    }
    @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    if @response["access_token"].present?
      self.oauth2_token = @response["access_token"]
      self.oauth2_token_expires_at = Time.now.utc + @response["expires_in"].to_i.seconds
      self.save!
    else
       # Something else bad happened
    end
  end


end


