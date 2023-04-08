class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :online, :heal, :aoe, :wins, :total_damage])
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


  def update_online_status
      if params['action'] == 'destroy'
        current_user.update(online: false)
      else
        current_user.update(online: true)
      end
  end



end
