# app/serializers/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
  # Specify the attributes you want to include in the JSON output.
  attributes :id, :email, :role, :created_at, :updated_at

  has_many :posts
  has_many :comments
  has_many :reactions

  def email
    object.email.upcase
  end
end
