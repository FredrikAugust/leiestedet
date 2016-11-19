class ListingController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    @listing = Listing.new(listing_params)
    @listing.user = current_user

    if @listing.save
      redirect_to listing_index_path, notice: 'Annonsen din er publisert'
    else
      render new_listing_path, error: 'Det var en feil med annonsen din'
    end
  end

  def destroy
    listing = Listing.find(params['id'])

    if listing.user == current_user
      listing.delete
      return redirect_to listing_index_path, notice: 'Annonsen ble slettet'
    else
      return redirect_to listing_path(listing),
                         error: 'Du har ikke rettigheter nok til dette'
    end
  end

  def update
  end

  def show
    @listing = Listing.find(params['id'])
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description)
  end
end
