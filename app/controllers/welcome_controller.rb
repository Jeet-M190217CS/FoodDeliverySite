class WelcomeController < ApplicationController
  before_action :logged_in_user
  def home
  end

  private
  def logged_in_user
    if user_logged_in?
        redirect_to '/dashboard/'+current_user.id.to_s
    end
end
end
