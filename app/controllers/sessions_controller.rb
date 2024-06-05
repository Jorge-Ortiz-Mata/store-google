class SessionsController < AuthenticatedController
  skip_before_action :authenticate_user
  before_action :block_access, only: %i[new create instructions]
  before_action :set_user, only: %i[recover recover_password]
  layout 'unauthenticated'

  def new
    @session = Authentication::Session.new
  end

  def create
    @session = Authentication::Session.new authentication_session_params

    if @session.save
      session[:user_id] = User.find_by(email: authentication_session_params[:email]).id
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def logout
    session[:user_id] = nil

    redirect_to login_path, notice: 'La sesión ha sido cerrada exitosamente'
  end

  def instructions
    @instructions = Authentication::Instructions.new
  end

  def instructions_send
    @instructions = Authentication::Instructions.new authentication_instructions_params

    if @instructions.save
      redirect_to login_path, notice: 'Se ha enviado un correo electrónico a tu bandeja principal de entrada o en la carpeta spam con las instrucciones para la recuperación de la contraseña'
    else
      render :instructions, status: :unprocessable_entity
    end
  end

  def recover
    @recover = Authentication::Recover.new
  end

  def recover_password
    @recover = Authentication::Recover.new authentication_recover_params

    if @recover.update
      @user.update(authentication_recover_params)
      @user.regenerate_recover_token

      redirect_to login_path, notice: 'Tu contraseña ha sido actualizada correctamente'
    else
      render :recover, status: :unprocessable_entity
    end
  end

  def confirmation
    @confirmation = Authentication::Confirmation.new
  end

  def confirmation_send
    @confirmation = Authentication::Confirmation.new authentication_confirmation_params

    if @confirmation.save
      redirect_to login_path, notice: 'El correo de confirmación ha sido enviado exitosamente'
    else
      render :confirmation, status: :unprocessable_entity
    end
  end

  private

  def authentication_session_params
    params.require(:authentication_session).permit(:email, :password)
  end

  def authentication_instructions_params
    params.require(:authentication_instructions).permit(:email)
  end

  def authentication_recover_params
    params.require(:authentication_recover).permit(:password, :password_confirmation)
  end

  def authentication_confirmation_params
    params.require(:authentication_confirmation).permit(:email)
  end

  def set_user
    @user = User.find_by(recover_token: params[:token])
  end
end
