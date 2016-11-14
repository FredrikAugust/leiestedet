class ListingController < ApplicationController
  before_action :authenticate_user!, except: [:index, :details]

  def index
    @listings = Listing.all
  end

  def new
    @listing = Listing.new
  end

  def create
    new_listing = Listing.new
    new_listing.title =  params[:listing][:title]
    new_listing.description = params[:listing][:description]
    new_listing.user = current_user

    if new_listing.save
      redirect_to listing_index_path, notice: 'Annonsen din er publisert'
    else
      @listing = new_listing
      redirect_to new_listing, notice: 'Det var en feil med annonsen din'
    end
  end

  def delete
  end

  def update
  end

  def details
  end
end
