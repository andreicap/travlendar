require 'rails_helper'

RSpec.describe VisitorsController, type: :controller do
  describe 'render corect templates' do
    
    it "GET #about to render about" do
      get :about
      expect(response).to render_template :about
    end

    it "GET #index to render index" do
      get :index
      expect(response).to render_template :index
    end
  end
end
