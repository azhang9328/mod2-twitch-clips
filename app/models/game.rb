class Game < ActiveRecord::Base 
    has_many :users_games 
    has_many :users, through: :users_games
    has_many :clips
    has_many :streamers, through: :clips
    has_many :favorite_clips

    def self.top_6
        Game.all.lazy.sort_by {|p| p.corf}.last(6)
    end

    def self.not_top_6
        Game.all.find_all do |game|
            !Game.top_6.include?(game)
        end
    end

    def top_6_clips
        cliparray = Clip.where(game_id: self.id)
        cliparray.lazy.sort_by {|p| p.corf}.last(6)
    end
end