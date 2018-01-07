require 'rails_helper'

RSpec.describe Users::OmniauthCallbacksController, :type => :controller  do 
  # include Devise::TestHelpers 

  before do 
    request.env["devise.mapping"] = Devise.mappings[:user] 
    request.env["omniauth.auth"] = OmniAuth.config.mock_auth[:google_oauth2] 
  end 
  describe 'Test oauth redirection feature' do
     
    it 'should authenticate and identify user if user is known' do 
      get :google_oauth2 
      expect(response).to redirect_to root_path 
    end 
  end

end 
