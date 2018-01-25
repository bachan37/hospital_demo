class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :get_layout

  protected
  def should_be_patient?
    redirect_to '/' and return if current_user.blank?
    redirect_to '/', notice: 'Invalid authorization' and return unless current_user.patient?
    return if current_user.patient?
  end

  def should_be_doctor?
    return if current_user.blank?
    return if current_user.patient?
  end

  def get_layout
    "application" if current_user.blank?
    "loggedin" if current_user.present?
  end
end
