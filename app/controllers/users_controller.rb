class UsersController < ApplicationController
    skip_before_action :logged_in?, only: [:new, :create]
    skip_before_action :current_user, only: [:show]
    def new 

    end

    def create 
        @user = User.new(params.require(:user).permit(:username, :password, :password_confirmation))
        if @user.save 
            redirect_to controller: 'sessions', action: 'new'
        else 
            flash[:alert] = "Forms must not be left blank."
            render 'new'
        end
    end

    def show 
        @user = User.find(params[:id])
    end
end