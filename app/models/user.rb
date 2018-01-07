
class User < ApplicationRecord

  # association with events, a user can have many events
  # when a user is deleted, all his events are deleted as well
  has_many :events, dependent: :destroy

  # devise authentication tool methods
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, :omniauth_providers => [:google_oauth2]

  # method to create a user from Google Authentication
  def self.from_omniauth(oauth)
    credentials = oauth.credentials
    data = oauth.info
    user = User.where(:email => data["email"]).first
    unless user
      password = Devise.friendly_token[0,20]
      user = User.create(
        name: data["name"], 
        email: data["email"],
        picture: data[:image],
        password: password, 
        password_confirmation: password,
        token: credentials.token,
        refresh_token: credentials.refresh_token
        )
    end
    user
  end

  #method to find user by authentication or create one if not present
  def self.find_for_google_oauth2(oauth, signed_in_resource=nil)
    credentials = oauth.credentials
    data = oauth.info
    user = User.where(email: data["email"]).first
    # puts "------","find for google data", data, "------"
    unless user
     user = User.create(
      first_name: data["first_name"],
      last_name: data["first_name"],
      picture: data["image"],
      email: data["email"],
      # url: data["google"],
      password: Devise.friendly_token[0,20],
      token: credentials.token,
      refresh_token: credentials.refresh_token)
   end
  end



end
