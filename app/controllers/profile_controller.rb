class ProfileController < ApplicationController
  def show
    if params[:id]
      @user = User.find_by(id: params[:id])
    else
      if user_signed_in?
        @user = current_user
      else
        redirect_to new_user_session_path
      end
    end
  end
end
