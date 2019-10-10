module UsersHelper
    class RestaurantUserRegistration include ActiveModel::Model
        attr_accessor :name, :email, :phone, :password, :password_confirmation,:restaurant_name, :street, :city, :pincode, :state

        def save
            return false if invalid?
            
            ActiveRecord::Base.transaction do
                user = User.create!(email: email, name: name, phone: phone, role: "R", password: password, password_confirmation: password_confirmation)
                res = Restaurant.create!(name: restaurant_name, user_id: user.id)
                res.create_address!(street: street, city: city, pincode: pincode, state: state)
            end
            true
        rescue ActiveRecord::StatementInvalid => e
            errors.add(:base, e.message)
            false
        
        rescue ActiveRecord::RecordInvalid => e
            errors.add(:base, e.message)
            false

        rescue ActiveRecord::Exception => e
            errors.add(:base, e.message)
            false
        end
    end
end
