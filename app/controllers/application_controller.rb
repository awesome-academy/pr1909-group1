class ApplicationController < ActionController::Base
  include JobPostsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :set_locale
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def set_locale
    locale = params[:locale].to_s.strip.to_sym
    I18n.locale = I18n.available_locales.include?(locale) ? locale : I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  protected

  def configure_permitted_parameters
    added_attrs = [
      :first_name, :last_name, :user_type, :email, :password, :password_confirmation,
      :remember_me, :current_password,
    ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
    return rails_admin_url if current_user.admin?
    url_for root_url
  end

  def check_not_deleted
    if controller_name.classify.constantize.find_by(id: params[:id]).nil?
      flash[:notice] = "This page doesn't exist"
      redirect_to root_url
    end
  end
end
