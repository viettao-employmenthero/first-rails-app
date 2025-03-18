# spec/factories/ports.rb
FactoryBot.define do
  factory :post do
    user { User.first }
    category { Category.first }
    title { 'test' }
  end
end
