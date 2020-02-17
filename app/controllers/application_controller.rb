class ApplicationController < ActionController::Base

  protected

  #Call this method in callbacks for require authentication
  def authenticate_user!
    if user_signed_in?
      super
    else
      flash[:warning] = "Debes tener una sesión abierta para continuar"
      redirect_to new_user_session_path
    end
  end
end
