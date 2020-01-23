class GamesController < ApplicationController
    def show 
        @game = Game.find(params[:id])
    end

    def favorite 
        @game = Game.find(params[:id])
        if !@user.games.include?(@game)
            @user.games << @game
            redirect_to controller: 'pages', action: 'home'
        else 
            redirect_to controller: 'games', action: 'show'
        end 
    end
end