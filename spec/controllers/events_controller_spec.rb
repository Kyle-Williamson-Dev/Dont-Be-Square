require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  describe "events#index action" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "events#new action" do
    it "should require users to be logged in" do
      get :new
      expect(response).to redirect_to new_user_session_path
    end

    it "should successfully show the new form" do
      user = Factorybot.create(:user)
      sign_in user

      get :new
      expect(response).to have_http_status(:success)
    end    
  end

  describe "events#create action" do

    it "should require users to be logged in" do
      post :create, params { event: { description: 'Play Halo' } }
    end

    it "should successfully create a new event in our database" do
        user = FactoryBot.create(:user)
        sign_in user

        post :create, params: { event: { description: 'Dungeons & Dragons Campaign Run' } }
        expect(response).to redirect_to root_path

        event = Event.last
        expect(event.description).to eq('Dungeons & Dragons Campaign Run')
        expect(event.user).to eq(user)
      end

    it "should properly deal with validation errors" do
      user = FactoryBot.create(:user)
      sign_in user

      event_count = Event.count
      post :create, params: { event: { description: '' } }
      expect(response).to have_http_status(:unprocessable_entity)
      expect(Event.count).to eq Event.count
    end

  end
end
