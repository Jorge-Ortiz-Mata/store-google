class UsersController < AuthenticatedController
  skip_before_action :authenticate_user, only: %i[new create confirm_account]
  before_action :block_access, only: %i[new create]
  before_action :set_user, only: %i[edit update show destroy confirm_account]
  before_action :authorize_user, only: %i[edit update destroy]
  layout 'unauthenticated', only: %i[new create]

  def new
    @user = User.new
  end

  def edit
    @update_account = Authentication::UpdateAccount.new(email: current_user.email)
  end

  def show; end

  def create
    @user = User.new user_params

    if @user.save
      UserMailer.with(user: @user).send_email_confirmation.deliver_later
      redirect_to login_path, notice: 'Para continuar, revisa tu bandeja de entrada principal o en la carpeta spam para que confirmes tu cuenta.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @update_account = Authentication::UpdateAccount.new(authentication_update_account_params)
    @update_account.id = current_user.id
    @update_account.uid = current_user.uid

    if @update_account.save
      redirect_to user_path(current_user.uid), notice: 'Tu cuenta ha sido actualizada exitosamente'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    @user.destroy

    redirect_to login_path, alert: 'Es una lástima que te despidas. Esperamos verte pronto nuevamente'
  end

  def confirm_account
    if @user.is_confirmed?
      redirect_to login_path, notice: 'Tu cuenta ya ha sido confirmada.'
    else
      @user.update!(is_confirmed?: true)
      redirect_to login_path, notice: 'Hurra! Tu cuenta de correo ha sido confirmada.'
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

  def authentication_update_account_params
    params.require(:authentication_update_account).permit(:email, :password, :password_confirmation, :old_password)
  end

  def set_user
    @user = User.find_by(uid: params[:uid])

    redirect_to root_path, notice: 'No hay ningún usuario registrado con este token.' if @user.nil?
  end

  def authorize_user
    return if current_user.eql? @user

    redirect_to root_path
  end
end
