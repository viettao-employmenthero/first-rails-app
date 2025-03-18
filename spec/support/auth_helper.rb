require 'jwt'

module AuthHelper
  def sign_in(user)
    payload = { user_id: user.id, role: user.role, exp: 24.hours.from_now.to_i }
    JWT.encode(payload, Rails.application.secret_key_base, 'HS256')
  end
end
