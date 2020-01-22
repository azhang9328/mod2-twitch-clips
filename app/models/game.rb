class Game < ActiveRecord::Base 
    has_many :users_games 
    has_many :users, through: :users_games
    has_many :clips
    has_many :streamers, through: :clips

    def self.top_6

    end

    def top_6_clips

    end
    
end