require 'rails_helper'
require 'carrierwave/test/matchers'

describe ListingImagesUploader do
  include CarrierWave::Test::Matchers

  let(:user) { create(:user) }
  let(:uploader) { ListingImagesUploader.new(user, :listingimages)}

  before(:all) do
    ListingImagesUploader.enable_processing = true
  end

  before(:each) do
    File.open(Rails.root.join('spec', 'assets', 'sample_image.png')) do |f|
      uploader.store!(f)
    end
  end

  after(:each) do
    uploader.remove!
  end

  context 'thumbnail' do
    it 'scales down the sample image to be 200x200' do
      expect(uploader.thumb).to have_dimensions(200, 200)
    end
  end

  context 'filetype' do
    it 'converts the image to a JPEG' do
      expect(uploader).to be_format('JPEG')
    end
  end

  context 'size' do
    it 'resizes the image to be <= 1280x720' do
      expect(uploader).to be_no_larger_than(1280, 720)
    end
  end
end
