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

  def new_house
    @new_house ||= House.new
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

  def edit_btn
    'fa fa-edit px-2'
  end

  def fist_icon
    "<i class='fa-sharp fa-solid fa-hand-fist'></i>"
  end

  def heal_icon
    "<i class='fa-solid fa-heart'></i>"
  end

  def kaboom_icon
    "<i class='fa-solid fa-meteor'></i>"
  end

  def thunder_icon
    "<i class='fa-solid fa-cloud-bolt'></i>"
  end

end
