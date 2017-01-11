require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = build(:user)
  end

  context 'attribute validation' do
    it 'doesnt throw any errors if all params are valid' do
      expect {
        @user.save!
      }.to_not raise_error
    end

    context 'first name' do
      it 'fails if without non-existant' do
        @user.first_name = ''
        expect(@user).to_not be_valid
      end

      it 'fails if contains anything but letters and spaces' do
        @user.first_name = 'Tommy2/'
        expect(@user).to_not be_valid
      end

      it 'fails if longer than 30 chars' do
        @user.first_name = 'K' * 31
        expect(@user).to_not be_valid
      end
    end

    context 'last name' do
      it 'fails to validate without value' do
        @user.last_name = ''
        expect(@user).to_not be_valid
      end

      it 'fails if contains anything but letters and spaces' do
        @user.last_name = 'T2/'
        expect(@user).to_not be_valid
      end

      it 'fails if is longer than 30 chars' do
        @user.last_name = 'K' * 31
        expect(@user).to_not be_valid
      end
    end

    context 'telephone' do
      it 'fails to validate without a telephone number' do
        @user.telephone = nil
        expect(@user).not_to be_valid
      end

      it 'fails to validate if telephone number contains anything but numbers and +' do
        @user.telephone = 'abcdabcd'
        expect(@user).not_to be_valid
      end

      it 'is ok if the user specifies an area code' do
        @user.telephone = '+47 999 22 777'
        expect(@user).to be_valid
      end

      it 'fails if the number is longer than 14 chars' do
        @user.telephone = '+999 888 999 888'
        expect(@user).to_not be_valid
      end

      it 'fails if the number is shorter than 8 chars' do
        @user.telephone = '8888888'
        expect(@user).to_not be_valid
      end
    end

    context 'location' do
      it 'fails to validate without value' do
        @user.location = ''
        expect(@user).to_not be_valid
      end

      it "fails if it's longer than 100 chars" do
        @user.location = 'a' * 101
        expect(@user).to_not be_valid
      end
    end

    context 'place_id' do
      it 'fails to validate without value' do
        @user.place_id = ''
        expect(@user).to_not be_valid
      end

      it "fails if it's longer than 100 chars" do
        @user.place_id = 'a' * 101
        expect(@user).to_not be_valid
      end
    end
  end

  context 'dependencies' do
    context 'listing' do
      it 'deletes all listings that belong to the user when user is deleted' do
        create(:listing, user: @user)

        expect {
          @user.destroy
        }.to change { Listing.count }.by(-1)
      end
    end
  end
end

