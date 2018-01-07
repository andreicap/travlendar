require 'rails_helper'


RSpec.describe UsersController, :type => :controller do
  
  describe 'GET #calendar' do
    it 'restrict calendar to be acccesed by visitor' do
      get :calendar
      expect(response).to redirect_to new_user_session_path
    end
  end

  describe 'GET #calendar' do
    login_user
    it 'allow signed in user to see calendar' do
      get :calendar
      expect(response).to render_template :calendar, :maps
      # expect(response).to render_template :maps
    end
  end

  describe 'GET #index' do
    login_user
    it 'redirect users to root path' do
      get :index
      expect(response).to redirect_to root_path
      # expect(response).to render_template :maps
    end
  end

  describe 'GET #show' do
    login_user
    user = 
    it 'redirect users to root path' do
      get :show, params: {id: 10}
      expect(response).to redirect_to root_path
      
    end
  end

  describe 'GET any for visitor' do
    it 'redirect visitors to sign in when trying to access anything' do
      get :index
      expect(response).to redirect_to new_user_session_path
    end
  end

  
  

end



