require 'rails_helper'

# spec/models/user_spec.rb
RSpec.describe User, type: :model do
  let(:user) { create(:user) }
  describe 'defaults' do
    it 'sets default role to user' do
      # user = User.create!(name: "Alice", email: "alice@example.com", password: "password", role: "admin")
      expect(user.role).to eq('user')
    end
  end

  describe 'default v2' do
    it 'sets default role to user' do
      # user = User.create!(name: "Alice", email: "alice@example.com", password: "password", role: "admin")
      expect(user.email).to eq('testauth@gmail.com')
    end
  end

  describe 'test association' do
    it 'has many posts' do
      # should have_many(:posts) # using shoulda-matchers -> one-liner syntax
      expect(User.reflect_on_association(:posts).macro).to eq(:has_many)
    end

    it 'has many comments' do
      should have_many(:comments)
    end

    it 'has no category' do
      should have_many(:categories)
    end
  end
end
