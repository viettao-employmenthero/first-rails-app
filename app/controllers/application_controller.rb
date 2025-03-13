class ApplicationController < ActionController::API
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
end
