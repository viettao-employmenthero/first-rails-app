# spec/controllers/authentication_controller_spec.rb
require 'rails_helper'

RSpec.describe AuthenticationController, type: :controller do
  describe 'POST #login' do
    let!(:user) { create(:user) }

    context 'with valid credentials' do
      it 'returns a token and user' do
        post :login, params: { email: 'testauth@gmail.com', password: '123456' }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('token', 'user')
      end
    end

    context 'with invalid credentials' do
      it 'returns an unauthorized status' do
        post :login, params: { email: 'testauth@gmail.com', password: 'wrong_password' }
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('error' => 'Invalid credentials')
      end
    end
  end
end