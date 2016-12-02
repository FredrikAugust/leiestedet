require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = build(:user)
  end

  context 'attribute validation' do
    context 'first name' do
      it 'validates without errors if first name is valid' do
        @user.save
        expect(@user.errors[:first_name].size).to eq(0)
      end

      it 'fails to validate without first name' do
        invalid_user = build(:user, first_name: '')
        expect(invalid_user).to_not be_valid
      end

      it 'fails to validate if first name contains anything but letters and spaces' do
        invalid_user = build(:user, first_name: 'Tommy2/')
        expect(invalid_user).to_not be_valid
      end

      it 'fails to validate if first name is longer than 30 chars' do
        invalid_user = build(:user, first_name: 'K' * 31)
        expect(invalid_user).to_not be_valid
      end
    end

    context 'last name' do
      it 'validates without errors if last name is valid' do
        @user.save
        expect(@user.errors[:last_name].size).to eq(0)
      end

      it 'fails to validate without last name' do
        invalid_user = build(:user, last_name: '')
        expect(invalid_user).to_not be_valid
      end

      it 'fails to validate if last name contains anything but letters and spaces' do
        invalid_user = build(:user, last_name: 'T2/')
        expect(invalid_user).to_not be_valid
      end

      it 'fails to validate if last name is longer than 30 chars' do
        invalid_user = build(:user, last_name: 'K' * 31)
        expect(invalid_user).to_not be_valid
      end
    end
  end
end

