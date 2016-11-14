class ListingController < ApplicationController
  before_action :authenticate_user!, except: [:index, :details]

  def index
    @listings = Listing.all
  end

  def create
    @listing = Listing.new
  end

  def delete
  end

  def update
  end

  def details
  end
end
