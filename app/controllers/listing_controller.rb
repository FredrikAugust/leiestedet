require 'json'
require 'net/http'

class ListingController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @listings = Listing.order(created_at: :desc)
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
      render 'new'
    end
  end

  def destroy
    listing = Listing.find_by(id: params['id'])

    unless listing
      return redirect_to listing_index_path, notice: 'Den annonsen finnes ikke'
    end

    if listing.user == current_user
      listing.remove_listingimages!
      listing.save
      listing.delete
      return redirect_to listing_index_path, notice: 'Annonsen ble slettet'
    else
      return redirect_to listing_path(listing),
                         error: 'Du har ikke rettigheter til dette'
    end
  end

  def edit
    @listing = Listing.find_by(id: params[:id])

    unless @listing
      return redirect_to listing_index_path, notice: 'Den annonsen finnes ikke'
    end

    unless @listing.user == current_user
      return redirect_to listing_path(@listing), notice: 'Du eier ikke denne annonsen'
    end
  end

  def update
    @listing = Listing.find_by(id: params[:id])

    unless @listing
      return redirect_to listing_index_path, notice: 'Den annonsen finnes ikke'
    end

    unless @listing.user == current_user
      return redirect_to listing_path(@listing),
        notice: 'Du er ikke autorisert til å gjøre endringer til denne annonsen'
    end

    if @listing.update_attributes(listing_params)
      redirect_to listing_path(@listing), notice: 'Din annonse har blitt endret'
    else
      render 'edit'
    end
  end

  def show
    @listing = Listing.find_by(id: params['id'])

    unless @listing
      return redirect_to listing_index_path, notice: 'Den annonsen finnes ikke'
    end
  end

  private

  def listing_params
    params.require(:listing).permit(:title, :description, :price,
                                    { listingimages: [] })
  end
end
