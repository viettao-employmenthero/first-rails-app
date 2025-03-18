# spec/requests/api/v1/comments_spec.rb
require 'rails_helper'
require_relative '../../spec/support/auth_helper'

RSpec.describe 'Api::V1::Posts', type: :request do
  let!(:user) { create(:user) }
  let(:category) { create(:category) }
  let(:post_model) { create(:post, user:, category:) }
  let(:token) { sign_in(user) } # add this line to test authenticate user

  before do
    # allow_any_instance_of(Api::V1::PostsController).to receive(:authenticate_user).and_return(true)
    allow_any_instance_of(Api::V1::PostsController).to receive(:current_user).and_return(user)
  end

  describe 'POST /api/v1/posts' do
    it 'creates a new post' do
      post '/api/v1/posts', params: { post: { title: 'New post', user: user.id, category_id: category.id } },
                            headers: { Authorization: token }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['title']).to eq('New post')
    end
  end

  describe 'GET /api/v1/posts/:id' do
    it 'returns the post' do
      get "/api/v1/posts/#{post.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(post.id)
    end
  end

  describe 'test' do
    it 'testing' do
      expect({ a: 1, b: 2 }).to include(:a)
    end
  end
end

