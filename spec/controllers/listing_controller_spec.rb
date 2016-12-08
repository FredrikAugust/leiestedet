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
    let!(:user) { create(:user) }

    it 'redirects user to login when trying to access while not logged in' do
      get :new
      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'returns an :ok if user is authenticated' do
      sign_in user
      get :new
      expect(response).to have_http_status(:ok)
    end

    it 'renders correct template if user is authenticated' do
      sign_in user
      get :new
      expect(response).to render_template(:new)
    end

    it 'assigns a new listing object' do
      sign_in user
      get :new
      expect(assigns(:listing)).to be_a_new(Listing)
    end
  end

  describe 'create' do
    let(:listing_params) do
      {
        listing: {
          title: Faker::Beer.name,
          description: Faker::ChuckNorris.fact,
          location: Faker::GameOfThrones.city,
          price: Faker::Number.number(3)
        }
      }
    end

    let!(:user) { create(:user) }

    it 'redirect to login if user is not authenticated' do
      post :create, params: listing_params

      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'sends user back to "new" if listing is invalid' do
      sign_in user

      listing_params[:listing][:price] = -100

      post :create, params: listing_params

      expect(response).to render_template(:new)
    end

    it 'creates a new listing if params are valid and user is logged in' do
      sign_in user

      expect{ post :create, params: listing_params }
        .to change{ Listing.count }.by(1)
    end

    it 'redirects to listing index if the listing was successful' do
      sign_in user

      post :create, params: listing_params

      expect(response).to redirect_to(action: :index, controller: :listing)
    end

    it 'does not create a new listing if invalid params' do
      sign_in user

      listing_params[:listing][:location] = ''

      expect{ post :create, params: listing_params }
        .to change{ Listing.count }.by(0)
    end

    it 'assigns the correct creator (user)' do
      sign_in user

      post :create, params: listing_params

      expect(Listing.first.user).to eq(user)
    end
  end

  describe 'destroy' do
    let!(:listing) { create(:listing) }

    it 'redirect to login if user is not authenticated' do
      delete :destroy, params: { id: listing.id }

      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'redirects to listing :index if listing does not exist' do
      sign_in listing.user

      delete :destroy, params: { id: 1000 }

      expect(response).to redirect_to(action: :index, controller: :listing)
    end

    it 'redirects back to listing if user does not have permission to delete' do
      sign_in create(:user)

      delete :destroy, params: { id: listing.id }

      expect(response).to redirect_to(action: :show, controller: :listing)
    end

    it 'does not delete if user is not authenticated' do
      sign_in create(:user)

      expect{ delete :destroy, params: { id: listing.id } }
        .to change{ Listing.count }.by(0)
    end

    it 'deletes if user is authenticated and listing exists' do
      sign_in listing.user

      expect{ delete :destroy, params: { id: listing.id } }
        .to change{ Listing.count }.by(-1)
    end
  end
end
