# spec/factories/comments.rb
FactoryBot.define do
  factory :comment do
    user { User.first }
    post { Post.first }
    content { 'test' }
  end
end
