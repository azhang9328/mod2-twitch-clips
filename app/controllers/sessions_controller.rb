class SessionsController < ApplicationController
    def new 

    end

    def create 
        user = User.find_by(username: params[:user][:username])
        user = user.try(:authenticate, params[:user][:password])
        if user
            session[:user_id] = user.id 
            @user = user 
            redirect_to controller: 'pages', action: 'home'
        else 
            flash[:alert] = "Incorrect, Try Again."
            render 'new'
        end
    end

    def destroy
        session.delete :user_id
    
        redirect_to '/'
    end
end