class ListingController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    new_listing = Listing.new(params[:listing])
    new_listing.user = current_user

    if new_listing.save
      redirect_to listing_index_path, notice: 'Annonsen din er publisert'
    else
      @listing = new_listing
      redirect_to new_listing, error: 'Det var en feil med annonsen din'
    end
  end

  def destroy
    listing = Listing.find(params['id'])

    if listing.user == current_user
      listing.delete
      return redirect_to listing_index_path, notice: 'Annonsen ble slettet'
    else
      return redirect_to listing_path(listing),
        error: 'Du har ikke rettigheter til aa slette denne annonsen'
    end
  end

  def update
  end

  def show
    @listing = Listing.find(params['id'])
  end
end
