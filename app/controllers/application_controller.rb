
# application controller
class ApplicationController < ActionController::API
  include Pundit::Authorization

  # Rescue from Pundit errors
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def authenticate_user
    header = request.headers['Authorization']
    return render json: { error: 'Unauthorized' }, status: :unauthorized unless header

    token = header.split(' ').last
    decoded = decode_token(token)
    @current_user = User.find_by(id: decoded['user_id'])
  rescue StandardError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end

  def authenticate_admin
    authenticate_user
    render json: { error: 'Forbidden' }, status: :forbidden unless @current_user&.role == 'admin'
  end

  private

  def decode_token(token)
    JWT.decode(token, Rails.application.secret_key_base, true, algorithm: 'HS256').first
  end

  def user_not_authorized
    render json: { error: 'You are not authorized to perform this action.' }, status: :forbidden
  end

  attr_reader :current_user
end
