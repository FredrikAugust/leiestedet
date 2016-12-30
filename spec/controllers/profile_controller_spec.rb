require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  describe 'show' do
    before(:all) do
      @user = create(:user)
    end

    it 'requires user to be logged in to view own profile' do
      get :show

      expect(response).to redirect_to(action: :new,
                                      controller: 'devise/sessions')
    end

    it 'allows logged in user to see own profile' do
      sign_in @user

      get :show

      expect(response).to render_template(:show)
    end

    it 'assigns the logged in user unless otherwise is specified' do
      sign_in @user

      get :show

      expect(assigns(:user)).to eq(@user)
    end

    it 'assigns the specified user by id' do
      get :show, params: { id: User.first.id }

      expect(assigns(:user)).to eq(User.first)
    end
  end
end
