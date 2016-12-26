class RemoveLocationFromListing < ActiveRecord::Migration[5.0]
  def change
    def up
      remove_column :listings, :location
    end

    def down
      add_column :listings, :location, :string
    end
  end
end
