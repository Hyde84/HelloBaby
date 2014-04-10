class ServicesController < ApplicationController

  def index
  end

  def create
    omniauth = request.env['omniauth.auth']
    if omniauth
      email = omniauth['extra']['raw_info']['email']
      name = omniauth['extra']['raw_info']['name']
      user = User.find_by_email(email) || User.create!(:email=>email, :name => name)
      session[:user_id] = email
      redirect_to :root, :notice => "Вы вошли"
    else
      render :text => 'Error: Omniauth is empty'
    end
  end
end
