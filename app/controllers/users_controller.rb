class UsersController < ApplicationController
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

end