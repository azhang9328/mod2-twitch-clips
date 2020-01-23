class PagesController < ApplicationController
    skip_before_action :logged_in?, only: [:home]
    def home
        @games = Game.top_6
    end
end