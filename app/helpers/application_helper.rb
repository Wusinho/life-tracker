module ApplicationHelper
  def resource_name
    :user
  end

  def resource_class
    User
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def blue_btn
    'btn btn-primary'
  end

  def green_btn
    'btn btn-success'
  end

  def red_btn
    'btn btn-danger'
  end

end
