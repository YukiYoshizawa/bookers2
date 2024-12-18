class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?


  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end
  # ログイン後どこに飛ぶかの設定
  
  def after_sign_out_path_for(resource)
    root_path
  end
  # ログアウト後どこに飛ぶかの設定

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

end
