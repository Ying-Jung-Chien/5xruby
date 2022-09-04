class ApplicationController < ActionController::Base
  before_action :set_locale

  # Make the current_user method available to views also, not just controllers:
  helper_method :current_user
  helper_method :admin

  # Define the current_user method:
  def current_user
    # Look up the current user based on user_id in the session cookie:
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to login_url, alert: "Please login!" if current_user.nil?
  end

  def authorize_admin
    redirect_to login_url, alert: "You don't have permission!" unless admin
  end

  def admin
    if current_user.nil?
      false
    elsif current_user.position == "supervisor"
      true
    end
  end

  def set_locale
    session[:locale] = params[:locale] if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)

    I18n.locale = session[:locale] || I18n.default_locale
  end
end
