require 'rails_helper'

RSpec.describe RegistrationsController, type: :controller do
  before :each do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe 'admin' do
    it 'rejects if user tries to create with admin param' do
      post :create, params: {
        user: {
          first_name: 'Tom',
          last_name: 'Hanks',
          email: 'tom@hanks.com',
          telephone: '+01 189 99 881',
          password: 'password',
          password_confirmation: 'password',
          location: 'Alabama, Wonderland',
          place_id: '01189998819991197253',
          admin: true
        }
      }
      expect(User.last.admin).to be_nil
    end

    it 'rejects if user tries to update with admin param' do
      sign_in create(:user)

      put :update, params: {
        user: {
          admin: true
        }
      }

      expect(User.last.admin).to be_nil
    end
  end
end
