class GamesController < ApplicationController
    def index 
        @games = Game.top_6
    end

    def show 
        @game = Game.find(params[:id])
    end

    def favorite 
        @game = Game.find(params[:id])
        if !@user.games.include?(@game)
            @user.games << @game
            redirect_to controller: 'games', action: 'index'
        else 
            redirect_to controller: 'games', action: 'show'
        end 
    end
end