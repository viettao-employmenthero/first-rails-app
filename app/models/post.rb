class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :reactions, dependent: :destroy

  validates :title, presence: true
end
