class PagesController < ApplicationController
    skip_before_action :logged_in?, only: [:home]
    def home
        @games = Game.top_6
    end

    def update_db 
        AskTwitch.update_db
        redirect_to controller: 'pages', action: 'home'
    end
end