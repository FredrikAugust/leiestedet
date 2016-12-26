class ProfileController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = current_user
    @listings = Listing.find_by(user: @user)
  end
end
