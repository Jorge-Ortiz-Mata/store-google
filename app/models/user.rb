class User < ApplicationRecord
  has_secure_password
  has_secure_token :uid, length: 30
  has_secure_token :recover_token, length: 30

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 8 }, on: :create
  validates :password_confirmation, presence: true, length: { minimum: 8 }, on: :create

  enum role: %i[member admin]

  def confirmed?
    active
  end
end
