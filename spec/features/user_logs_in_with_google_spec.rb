# RSpec.describe Users::OmniauthCallbacksController do
#   before :each do
#     # This a Devise specific thing for functional tests. See https://github.com/plataformatec/devise/issues/608
#     request.env["devise.mapping"] = Devise.mappings[:user]
#   end
#   describe ".create" do

#     it "should redirect back to sign_up page with an error when omniauth.auth is missing" do
#       @controller.stub!(:env).and_return({"some_other_key" => "some_other_value"})
#       get :google_oauth2
#       flash[:error].should be
#       flash[:error].should match /Unexpected response from Google \./
#       response.should redirect_to new_user_registration_url
#     end

#     it "should redirect back to sign_up page with an error when provider is missing" do
#       stub_env_for_omniauth(nil)
#       get :google_oauth2
#       flash[:error].should be
#       flash[:error].should match /Unexpected response from Google: Provider information is missing/
#       response.should redirect_to new_user_registration_url
#     end
#   end
# end
