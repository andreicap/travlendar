
class User < ApplicationRecord

  has_many :events, dependent: :destroy

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(oauth)
    credentials = oauth.credentials
    data = oauth.info
    puts "------", "oauth", oauth.credentials, "------"
    puts "------", "data", data, "------"
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
