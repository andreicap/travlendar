require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  context "Google callback" do
    setup do
      # This a Devise specific thing for functional tests. See https://github.com/plataformatec/devise/issues/closed#issue/608
      request.env["devise.mapping"] = Devise.mappings[:user]      
    end
    
  #   it "sign in when it's called with a valid user" do
  #     u = users(:andmej)
  #     @controller.expects(:env).returns("omniauth.auth" => { "extra" => { "user_hash" => { "email" => u.email, "name" => u.name, "id" => u.facebook_uid } } })
  #     get :google_oauth2
  #     assert_redirected_to root_path
  #     assert_match flash[:notice], /You have signed in through Google/
  #   end
    
  #   it "store the OmniAuth hash in the session and redirect to the new user page when it's called with an invalid user" do
  #     env = { "omniauth.auth" => { "extra" => { "user_hash" => { "email" => "ghost@nobody.com", :id => "1234" } } } }
  #     @controller.expects(:env).twice.returns(env)
  #     get :google_oauth2
  #     assert_equal session["devise.google_oauth2_data"], env["omniauth.auth"]
  #     assert_redirected_to new_user_registration_path
  #   end
  end
end