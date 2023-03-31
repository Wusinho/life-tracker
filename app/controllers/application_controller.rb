class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :online, :heal, :aoe, :wins, :total_games, :total_damage])
  end

  def error_message(msg)
    message = msg.instance_of?(String) ? msg : msg.errors.full_messages.to_sentence
    render_turbo(message)
  end

  def rescue_msg(msg)
    render_turbo(msg.message)
  end

  def render_turbo(message)
    render turbo_stream: turbo_stream.replace('error_message', partial: 'shared/error_message',
                                              locals: { message: message })
  end


  def update_online_status(action)
    current_user.update_attribute(:online, !current_user.online )
    current_user.worker? ? broadcast_worker_status(action) : broadcast_employer_status(action)
  end



end
