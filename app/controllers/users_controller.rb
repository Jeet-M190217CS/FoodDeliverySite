class UsersController < ApplicationController
    before_action :logged_in_user, only: [:show, :dashboard]
    before_action :correct_user, only: [:show, :dashboard]

    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            flash[:info] = "Update Profile details"
            flash[:success] = "Sign Up Successfully !!!"
            log_in @user
            redirect_to @user
        else
            render 'new'
        end
    end

    def update
        @user = User.find(params[:id])
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.phone = params[:user][:phone]

        if params[:user].has_key?(:image)
            @user.image = params[:user][:image]
        end

        @adrs = Address.find_by(parent_ref_id:params[:id], parent_ref_type:"User")
        @adrs ||= Address.new
        @adrs.street = params[:user][:street]
        @adrs.city = params[:user][:city]
        @adrs.pincode = params[:user][:pincode]
        @adrs.state = params[:user][:state]

        @user.valid?

        if @adrs.valid?
            @user.address = @adrs
        else
            @adrs.errors.full_messages.each do |msg|
                @user.errors.add(:base,msg)
            end
        end

        if params[:user][:password] != "dummyvalue" || params[:user][:confirm_password] != "dummyvalue"
            if params[:user][:password].length < 6
                @user.errors.add(:password, :too_short, message: "is too short (minimum is 6 characters)")
            elsif params[:user][:password]!= params[:user][:confirm_password]
                @user.errors.add(:password_confirmation, :confirmation, message: "doesn't match Password")
            else
                @user.password = params[:user][:password]
                @user.password_confirmation = params[:user][:confirm_password]
            end
        end

        if @user.errors.count > 0
            render 'show'
            return
        end

        if @user.save
            flash.now[:success] = "Profile Updated Suceesfully."
        end

        render 'show'
    end

    def dashboard
        @user = User.find_by(id: params[:id])
        if (@user.role == "A")
            admin_dashboard
        elsif (@user.role == "U")
            user_dashboard
        else
            restaurant_user_dashboard
        end
    end

    def user_dashboard
        @restaurants = Restaurant.all
    end

    def admin_dashboard
        @orders = Order.all
        @neworders = Order.where("NOT status='D'")
    end

    def restaurant_user_dashboard
    
    end

    private
    def user_params
        para = params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :image)
        para['role'] = params['role']
        para
    end

    def logged_in_user
        unless user_logged_in?
            flash[:danger]  = "Please log in."
            redirect_to login_url
        end
    end

    def correct_user
        @user = User.find_by(id: params[:id])
        
        if !current_user?(@user)
            log_out
            flash[:danger] = "Invalid Action !!!"
            redirect_to(root_url)
        end
    end
end
