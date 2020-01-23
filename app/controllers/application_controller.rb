class ApplicationController < ActionController::Base
    before_action :current_user, :logged_in?

    def current_user
      @user = User.find_by(id: session[:user_id]) || User.new
    end

    def logged_in?
        if !current_user.id
            redirect_to controller: 'pages', action: 'home'
        end
    end

end
