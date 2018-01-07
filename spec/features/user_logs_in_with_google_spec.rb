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

  # it "store the OmniAuth hash in the session and redirect to the new user page when it's called with an invalid user" do
  #     env = { "omniauth.auth" => { "extra" => { "user_hash" => { "email" => "ghost@nobody.com", :id => "1234" } } } }
  #     controller.expects(:env).twice.returns(env)
  #     get :google_oauth2
  #     assert_equal session["devise.google_oauth2_data"], env["omniauth.auth"]
  #     assert_redirected_to new_user_registration_path
  # end

end 
