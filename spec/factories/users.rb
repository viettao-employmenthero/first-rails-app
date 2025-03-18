# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { 'Test User' }
    email { 'viettao@gmail.com' }
    password { '123456' }
  end
end
