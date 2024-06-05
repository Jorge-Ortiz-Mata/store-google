module Authentication
  class Session
    include ActiveModel::Model

    attr_accessor :email, :password

    validates :email, :password, presence: true
    validates :password, length: { minimum: 8 }
    validate :user_exists?
    validate :user_authentication
    validate :user_is_confirmed?

    def save
      return false if invalid?

      true
    end

    private

    def user_exists?
      return unless email.present?

      errors.add(:email, :user_nil) unless User.find_by(email: email).present?
    end

    def user_authentication
      user = User.find_by(email: email)

      errors.add(:password, :incorrect_credentials) unless user&.authenticate(password)
    end

    def user_is_confirmed?
      user = User.find_by(email: email)

      errors.add(:email, :is_not_confirmed) unless user&.is_confirmed?
    end
  end
end
