class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments
  has_many :reactions

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: %w[admin user] }

  before_save { self.email = email.downcase }
  after_save :send_welcome_email

  def send_welcome_email
    puts "Welcome email sent to #{email}"
  end
end
