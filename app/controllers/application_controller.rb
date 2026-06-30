class ApplicationController < ActionController::Base
  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

  layout :layout_by_resource

  protected

  def configure_permitted_parameters
    # Autorise username à l'inscription
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    # Autorise username à la mise à jour du profil
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end

  def layout_by_resource
    devise_controller? ? "devise" : "application"
  end
end
