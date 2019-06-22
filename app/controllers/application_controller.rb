class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  private 

  def not_authorized
  	redirect_to root_path, alert: 'Not allowed to access this page'
  end
end
