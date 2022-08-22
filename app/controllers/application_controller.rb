class ApplicationController < ActionController::Base
  before_action :set_locale

  def set_locale
    # 可以將 ["en", "zh-CN"] 設定為 VALID_LANG 放到 config/environment.rb 中
    session[:locale] = params[:locale] if params[:locale] && I18n.available_locales.include?(params[:locale].to_sym)

    I18n.locale = session[:locale] || I18n.default_locale
  end
end
