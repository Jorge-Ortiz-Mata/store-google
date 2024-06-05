module Authentication
  class UpdateAccount
    include ActiveModel::Model

    attr_accessor :id, :email, :password, :password_confirmation, :old_password, :uid

    validates :email, :old_password, presence: true
    validates :password, presence: true, if: :password_confirmation_is_present?
    validates :password_confirmation, presence: true, if: :password_is_present?

    validates :password, length: { minimum: 8 }, if: :password_is_present?
    validates :password_confirmation, length: { minimum: 8 }, if: :password_confirmation_is_present?
    validate :same_passwords, if: :both_passwords_are_present?
    validate :validate_current_password
    validate :not_repeated_email

    def save
      return false if invalid?

      User.find(id).update(email: email, password: password, password_confirmation: password_confirmation)

      true
    end

    private

    def same_passwords
      errors.add(:password_confirmation, :passwords_do_not_match) unless password.eql? password_confirmation
    end

    def both_passwords_are_present?
      return true if password.present? && password_confirmation.present?

      false
    end

    def password_is_present?
      return true if password.present?

      false
    end

    def password_confirmation_is_present?
      return true if password_confirmation.present?

      false
    end

    def validate_current_password
      return unless old_password.present?

      errors.add(:old_password, :incorrect_credentials) unless User.find(id).authenticate(old_password)
    end

    def not_repeated_email
      user = User.find_by(email: email)

      return unless user.present?

      return if user.uid.eql? uid

      errors.add(:email, 'ya ha sido registrado')
    end
  end
end
