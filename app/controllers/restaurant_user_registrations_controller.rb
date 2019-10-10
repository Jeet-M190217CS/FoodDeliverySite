class RestaurantUserRegistrationsController < ApplicationController
  def new
    @registration = RestaurantUserRegistration.new
  end

  def create
    @registration  = RestaurantUserRegistration.new
    hash = params[:users_helper_restaurant_user_registration]

    @registration.name = hash[:name]
    @registration.email = hash[:email]
    @registration.phone = hash[:phone]
    @registration.password = hash[:password]
    @registration.password_confirmation = hash[:password_confirmation]
    @registration.restaurant_name = hash[:restaurant_name]
    @registration.street = hash[:street]
    @registration.pincode = hash[:pincode]
    @registration .city = hash[:city]
    @registration .state = hash[:state]

    if @registration.save
      user = User.find_by(email: hash[:email])
      flash[:success] = "Registration Successfull!!"
      log_in user
      redirect_to '/dashboard/'+user.id.to_s
    else
      render :new
    end
  end
end
