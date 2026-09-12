class Users::RegistrationsController < Devise::RegistrationsController
  prepend_before_action :authenticate_scope!, only: %i[edit update destroy confirm_destroy]

  def confirm_destroy
  end

  def destroy
    password = params.dig(:user, :current_password)

    if password.present? && resource.valid_password?(password)
      super
    else
      resource.errors.add(:current_password,
        password.blank? ? "Enter your password to confirm" : "That password is incorrect")
      render :confirm_destroy, status: :unprocessable_content
    end
  end

  protected

  def after_update_path_for(resource)
    user_path(resource)
  end
end
