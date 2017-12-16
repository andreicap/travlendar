class User < ApplicationRecord

  # has_one :calendar

  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, 
  :omniauthable, :omniauth_providers => [:google_oauth2]

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      password = Devise.friendly_token[0,20]
      user = User.create(name: data["name"], email: data["email"],
        password: password, password_confirmation: password
        )
    end
    user
  end

  def self.find_for_google_oauth2(oauth, signed_in_resource=nil)
    credentials = oauth.credentials
    data = oauth.info
    user = User.where(email: data["email"]).first
    
    unless user
     user = User.create(
      first_name: data["first_name"],
      last_name: data["first_name"],
      picture: data["image"],
      email: data["email"],
      password: Devise.friendly_token[0,20],
      token: credentials.token,
      refresh_token: credentials.refresh_token)
   end
    @calendar = user.get_google_calendars  
    user
  end

end
