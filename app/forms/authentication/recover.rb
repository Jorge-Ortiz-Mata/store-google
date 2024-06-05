module Authentication
  class Recover
    include ActiveModel::Model

    attr_accessor :password, :password_confirmation

    validates :password, :password_confirmation, presence: true
    validates :password, :password_confirmation, length: { minimum: 8 }
    validate :passwords_match

    def update
      return false if invalid?

      true
    end

    private

    def passwords_match
      return if password.eql? password_confirmation

      errors.add(:password, :are_not_equal)
    end
  end
end
