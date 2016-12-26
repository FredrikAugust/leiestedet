require 'rails_helper'

RSpec.describe ProfileController, type: :controller do
  describe 'show' do
    before(:all) do
      @user = create(:user)
    end

    it 'requires user to be logged in' do
      get :show

      expect(response).to redirect_to(action: :new, controller: 'devise/sessions')
    end

    it 'allows logged in user to see own profile' do
      sign_in @user

      get :show

      expect(response).to render_template(:show)
    end
  end
end

