# spec/requests/api/v1/comments_spec.rb
require 'rails_helper'

RSpec.describe 'Api::V1::Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post, user:, category:) }
  let!(:comment) { create(:comment, user:, post:) }

  before do
    allow_any_instance_of(Api::V1::CommentsController).to receive(:authenticate_user).and_return(true)
    allow_any_instance_of(Api::V1::CommentsController).to receive(:current_user).and_return(user)
  end
  describe 'POST /api/v1/comments' do
    it 'creates a new comment' do
      post '/api/v1/comments', params: { comment: { content: 'Great post!', post_id: post.id } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['content']).to eq('Great post!')
    end
  end

  describe 'GET /api/v1/comments/:id' do
    it 'returns the comment' do
      get "/api/v1/comments/#{comment.id}"

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['id']).to eq(comment.id)
    end
  end

  describe 'PUT /api/v1/comments/:id' do
    it 'updates the comment' do
      put "/api/v1/comments/#{comment.id}", params: { comment: { content: 'Updated content' } }

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['content']).to eq('Updated content')
    end
  end

  describe 'DELETE /api/v1/comments/:id' do
    it 'deletes the comment' do
      delete "/api/v1/comments/#{comment.id}"

      expect(response).to have_http_status(:no_content)
    end
  end
end