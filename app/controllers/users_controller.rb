class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        
        if @user.save
            #saves successfully redirect to profile page (i.e users#show)
            flash[:success] = "Sign Up Successfully !!! "
            flash[:info] = "Update Profile details"
            redirect_to @user
        else
            #erros
            render 'new'
        end
    end

    def user_params
        para = params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation)
        para['role'] = params['role']
        para
    end
end
