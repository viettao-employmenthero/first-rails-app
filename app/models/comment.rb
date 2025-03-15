# Comments are associated with a user and a post. They have a content field that must be present.
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end
