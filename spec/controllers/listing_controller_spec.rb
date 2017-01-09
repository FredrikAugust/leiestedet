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

      expect(assigns(:listings).first).to eq(Listing.last)
    end

    describe 'search' do
      it 'not return listings that do not match the search' do
        create(:listing, title: 'this is the test, alright?')

        get :index, params: { sokeord: 'not the test' }

        expect(assigns(:listings)).to_not include(Listing.find_by(title: 'this is the test, alright?'))
      end

      it 'return listings that match the search' do
        create(:listing, title: 'this is the test, alright?')

        get :index, params: { sokeord: 'this is the test' }

        expect(assigns(:listings)).to include(Listing.find_by(title: 'this is the test, alright?'))
      end

      it 'returns all listings if search query is empty' do
        listings = (0..10).map { create(:listing) }

        get :index, params: { sokeord: '' }

        expect(assigns(:listings)).to eq(listings.sort_by(&:created_at).reverse)
      end
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

      expect(response).to redirect_to(listing_path(Listing.last))
    end

    it 'does not create a new listing if invalid params' do
      sign_in user

      listing_params[:listing][:title] = ''

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

  describe 'edit' do
    let!(:listing) { create(:listing) }

    it 'redirects to login if user is not authenticated' do
      get :edit, params: { id: listing.id }

      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'redirects to listing if user does not own the listing' do
      sign_in create(:user)

      get :edit, params: { id: listing.id }

      expect(response).to redirect_to(listing_path(listing))
    end

    it 'redirects to all listings if listing does not exist' do
      sign_in listing.user

      get :edit, params: { id: 123123 }

      expect(response).to redirect_to(listing_index_path)
    end

    it 'renders the edit page if user owns it and it exists' do
      sign_in listing.user

      get :edit, params: { id: listing.id }

      expect(response).to render_template(:edit)
    end

    it 'assigns the correct listing when editing' do
      sign_in listing.user

      get :edit, params: { id: listing.id }

      expect(assigns(:listing)).to eq(listing)
    end
  end

  describe 'update' do
    let!(:listing) { create(:listing) }

    let!(:update_params) do
      {
        id: listing.id,
        listing: {
          title: "New Title"
        }
      }
    end

    it 'redirects to login page if user is not logged in' do
      patch :update, params: update_params

      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'redirects to listing index path if listing does not exist' do
      sign_in listing.user

      update_params[:id] = 200

      patch :update, params: update_params

      expect(response).to redirect_to(listing_index_path)
    end

    it 'redirects to listing if user does not own it' do
      sign_in create(:user)

      patch :update, params: update_params

      expect(response).to redirect_to(listing_path(listing))
    end

    it 'updates attributes to the values specified by the user' do
      sign_in listing.user

      old_title = listing.title

      expect{ patch :update, params: update_params }
        .to change{ listing.reload.title }.from(old_title)
        .to(update_params[:listing][:title])
    end

    it 'does not update attributes if user is not the owner' do
      sign_in create(:user)

      expect{ patch :update, params: update_params }
        .to_not change{ listing.reload.title }
    end

    it 'renders the edit page if params are not valid' do
      sign_in listing.user

      update_params[:listing][:price] = -100

      patch :update, params: update_params

      expect(response).to render_template(:edit)
    end

    it 'assigns the edited listing object when user inserts invalid values' do
      sign_in listing.user

      update_params[:listing][:price] = -100

      patch :update, params: update_params

      expect(assigns(:listing)).to eq(listing.reload)
    end
  end

  describe 'show' do
    let!(:listing) { create(:listing) }

    it 'allows non-authed users to view' do
      get :show, params: { id: listing.id }

      expect(response).to render_template(:show)
    end

    it 'assigns correct listing' do
      get :show, params: { id: listing.id }

      expect(assigns(:listing)).to eq(listing)
    end

    it 'redirects to listing index if listing does not exist' do
      get :show, params: { id: 111 }

      expect(response).to redirect_to(listing_index_path)
    end
  end
end
