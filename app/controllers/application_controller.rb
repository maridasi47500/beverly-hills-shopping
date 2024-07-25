class ApplicationController < ActionController::Base
  before_action :authorize
  before_action :seti18n
  protected
  def seti18n
    parsed=locale=params[:locale]
    if params[:locale]
      if I18n.available_locales.map(&:to_s).include?(parsed_locale) 
        I18n.locale=parsed_locale
      else
        flash.now[:notice]="#{parsed_locale} translation not available"
        logger.error flash.now[:notice]
      end
    end
  end
  def authorize
    unless User.find_by(id: session[:user_id])
      redirect_to login_url, notice: 'please log in'
    end
  end
end
