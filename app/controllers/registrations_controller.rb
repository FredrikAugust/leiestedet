class RegistrationsController < Devise::RegistrationsController
  private

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password,
                                 :password_confirmation,
                                 :place_id, :location)
  end

  def account_update_params
    params.require(:user).permit(:first_name, :last_name, :email,
                                 :current_password, :password_confirmation,
                                 :place_id, :location)
  end
end
