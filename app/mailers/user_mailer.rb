class UserMailer < ApplicationMailer
  default from: ENV['SENDGRID_EMAIL_VALID']
  layout 'mailer'

  def send_email_confirmation
    @user = params[:user]
    @url = "http://localhost:3000/email/confirmation/#{@user.uid}"
    mail(to: @user.email, subject: 'Kalenda - Confirmación de correo electrónico')
  end

  def password_instructions
    @user = params[:user]
    @url = "http://localhost:3000/recover/#{@user.recover_token}"
    mail(to: @user.email, subject: 'Kalenda - Recuperación de contraseña')
  end
end
