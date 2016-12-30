class AddListingimagesToListings < ActiveRecord::Migration[5.0]
  def change
    add_column :listings, :listingimages, :json
  end
end
