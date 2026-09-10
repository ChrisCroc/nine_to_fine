class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def not_found
    render status: :not_found
  end

  def unprocessable_content
    render status: :unprocessable_content
  end

  def bad_request
    render_public_page 400
  end

  def internal_server_error
    render_public_page 500
  end

  private

  def render_public_page(status)
    render file: Rails.public_path.join("#{status}.html"), layout: false, status: status
  end
end
