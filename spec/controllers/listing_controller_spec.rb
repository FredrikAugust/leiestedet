require 'rails_helper'

RSpec.describe ListingController, type: :controller do
  describe 'index' do
    it 'returns OK' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'renders correct view' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'assigns all listings to variable' do
      get :index
      expect(assigns(:listings).count).to eq(Listing.all.count)
    end

    it 'sorts listings from new to old' do
      user = create(:user)
      create(:listing, title: "Test Post Now", user: user)
      create(:listing, created_at: 1.hour.from_now, title: "Test Post 1H", user: user)
      get :index
      expect(assigns(:listings)).to eq(Listing.order(created_at: :desc))
    end
  end

  describe 'new' do
    it 'redirects user to login when trying to access while not logged in' do
      get :new
      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'returns an :ok if user is authenticated' do
      sign_in create(:user)
      get :new
      expect(response).to have_http_status(:ok)
    end

    it 'renders correct template if user is authenticated' do
      sign_in create(:user)
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new listing object' do
      sign_in create(:user)
      get :new
      expect(assigns(:listing)).to be_a_new(Listing)
    end
  end

  describe 'create' do
    let(:listing_params) {
      { listing: {
        title: Faker::Beer.name,
        description: Faker::ChuckNorris.fact,
        price: Faker::Number.number(3),
        location: Faker::GameOfThrones.city
      } }
    }

    it 'redirect to login if user is not authenticated' do
      post :create, params: @listing_params

      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end
  end
end
