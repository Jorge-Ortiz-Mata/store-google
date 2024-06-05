class AuthenticatedController < ApplicationController
  before_action :authenticate_user
  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  private

  def authenticate_user
    redirect_to login_path, notice: 'Debes iniciar sesión antes de continuar' unless logged_in?
  end

  def block_access
    redirect_to root_path if session[:user_id]
  end
end
