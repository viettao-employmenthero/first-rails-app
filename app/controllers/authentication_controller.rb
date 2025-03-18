class AuthenticationController < ApplicationController
  require 'jwt'

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = generate_token(user)
      render json: { token: token, user: user }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  # private

  def generate_token(user)
    payload = { user_id: user.id, role: user.role, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end
end
