class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :online, :heal, :harakiri, :aoe, :wins, :total_games])
  end


  def error_message(house)
    message = house.instance_of?(String) ? house : house.errors.full_messages.to_sentence

    render turbo_stream: turbo_stream.replace('error_message', partial: 'shared/error_message',
                         locals: { message: message })
  end

  def update_online_status(action)
    current_user.update_attribute(:online, !current_user.online )
    current_user.worker? ? broadcast_worker_status(action) : broadcast_employer_status(action)
  end



end
