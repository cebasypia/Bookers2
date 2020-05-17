class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # デバイス機能実行前にconfigure_permitted_parametersの実行をする。
  protect_from_forgery with: :exception

  protected

  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  # sign_out後のredirect先変更する。rootパスへ。rootパスはhome topを設定済み。
  def after_sign_out_path_for(resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
    # sign_upの際にnameのデータ操作を許。追加したカラム。
  end
end
