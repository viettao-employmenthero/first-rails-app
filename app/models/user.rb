class User < ApplicationRecord
  has_secure_password

  has_many :posts
  has_many :comments
  has_many :reactions

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :role, inclusion: { in: %w[admin user] }

  before_save { self.email = email.downcase }
  after_initialize :set_default_role, if: :new_record?

  def send_welcome_email
    puts "Welcome email sent to #{email}"
  end

  private

  def set_default_role
    self.role ||= 'user'
  end
end
