require 'rails_helper'

RSpec.describe Listing, type: :model do
  before(:each) do
    @listing = build(:listing)
  end

  context 'attribute validation' do
    it "doesn't throw any errors if all params are valid" do
      expect {
        @listing.save!
      }.to_not raise_error
    end

    context 'title' do
      it 'contains no errors if values are valid' do
        @listing.save
        expect(@listing.errors[:title].size).to eq(0)
      end

      it 'fails if no value is supplied' do
        @listing.title = ''
        expect(@listing).to_not be_valid
      end

      it 'fails if less than 2 characters long' do
        @listing.title = 'K'
        expect(@listing).to_not be_valid
      end

      it 'fails if longer than 50 chars' do
        @listing.title = 'K' * 51
        expect(@listing).to_not be_valid
      end
    end

    context 'description' do
      it 'contains no errors if value is valid' do
        @listing.save
        expect(@listing.errors[:description].size).to eq(0)
      end

      it 'fails if no value is supplied' do
        @listing.description = ''
        expect(@listing).to_not be_valid
      end

      it 'fails if less than 2 characters long' do
        @listing.description = 'K'
        expect(@listing).to_not be_valid
      end

      it 'fails if longer than 400 characters long' do
        @listing.description = 'K' * 401
        expect(@listing).to_not be_valid
      end
    end

    context 'price' do
      it 'contains no errors if value is valid' do
        @listing.save
        expect(@listing.errors[:price].size).to eq(0)
      end

      it 'fails if value is nil/non-existant' do
        @listing.price = nil
        expect(@listing).to_not be_valid
      end

      it 'fails if type is not integer' do
        @listing.price = 99.99
        expect(@listing).to_not be_valid
      end

      it 'fails if price is under 0' do
        @listing.price = -100
        expect(@listing).to_not be_valid
      end
    end

    context 'user' do
      it 'throws error if user is not set' do
        @listing.user = nil
        expect(@listing).to_not be_valid
      end
    end
  end
end
