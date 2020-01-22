class Game < ActiveRecord::Base 
    has_many :users_games 
    has_many :users, through: :users_games
    def self.top_10
        response = RestClient.get 'https://api.twitch.tv/helix/games/top?first=10', {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        games = JSON.parse(response)
        games['data'].map do |game|
            img_url = game['box_art_url']
            img_url["{width}x{height}"] = "200x200"
            Game.find_or_create_by(tw_id: game['id'], name: game['name'], img_url: img_url)
        end
    end
end