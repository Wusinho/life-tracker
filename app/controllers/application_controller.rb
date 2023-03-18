class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end


  def error_message(house)
    turbo_stream.replace('error_message', partial: 'shared/error_message',
                         locals: { message: house.errors.full_messages.to_sentence })
  end
end
