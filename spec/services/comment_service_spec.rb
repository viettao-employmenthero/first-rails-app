# spec/services/comment_service_spec.rb
require 'rails_helper'

RSpec.describe Comments::CommentsService, type: :service do
  let!(:user) { create(:user) }
  let!(:category) { create(:category) }
  let!(:post) { create(:post, user:, category:) }
  let!(:valid_params) { { content: 'Great post!', post_id: post.id } }
  let!(:invalid_params) { { content: 'Great post!', post_id: nil } }
  let!(:service) { described_class.new(user, valid_params) }

  describe '#validate_comment_params' do
    context 'when the post belongs to the user' do
      it 'returns permitted params' do
        expect(service.send(:validate_comment_params)).to eq(valid_params.stringify_keys)
      end
    end

    context 'when the post does not belong to the user' do
      let!(:other_user) { create(:user, email: 'other_user@gmail.com') }
      let!(:other_post) { create(:post, user: other_user) }
      let!(:invalid_user_params) { { content: 'Great post!', post_id: other_post.id } }
      let!(:service) { described_class.new(user, invalid_user_params) }

      it 'raises an error' do
        expect { service.send(:validate_comment_params) }.to raise_error('Invalid comment: user\'s post not correspond with current_user')
      end
    end

    context 'when the parent comment does not correspond with the post' do
      let!(:parent_comment) { create(:comment, post: create(:post)) }
      let!(:invalid_parent_params) { { content: 'Great post!', post_id: post.id, parent_id: parent_comment.id } }
      let!(:service) { described_class.new(user, invalid_parent_params) }

      it 'raises an error' do
        expect { service.send(:validate_comment_params) }.to raise_error('Invalid comment: parent comment not correspond with post or parent not exist')
      end
    end
  end
end