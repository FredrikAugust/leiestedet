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
      it 'contains no errors if first name is valid' do
        @user.save
        expect(@user.errors[:first_name].size).to eq(0)
      end

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
      it 'contains no errors if value is valid' do
        @user.save
        expect(@user.errors[:last_name].size).to eq(0)
      end

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
  end
end

