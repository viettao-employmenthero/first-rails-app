class Reaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  enum reaction_type: { like: 0, dislike: 1 }

  validates :reaction_type, presence: true
end
