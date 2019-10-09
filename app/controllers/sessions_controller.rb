class SessionsController < ApplicationController
  before_action :not_logged_in, only: [:new]

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      #redirect user to dashboard
      flash[:success] = 'Logged in Successfully!!!'
      redirect_to '/dashboard/'+user.id.to_s
    else
      flash.now[:danger] = 'Invalid email/password'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:success] = 'Logged out Successfully!!!'
    redirect_to root_path
  end

  private

  def not_logged_in
    if user_logged_in?
      redirect_to '/dashboard/'+current_user.id.to_s
    end
  end
end
