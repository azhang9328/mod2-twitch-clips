class Game < ActiveRecord::Base 
    has_many :users_games 
    has_many :users, through: :users_games
    has_many :clips
    has_many :streamers, through: :clips
    def self.top_10
        response = RestClient.get 'https://api.twitch.tv/helix/games/top?first=10', {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        games = JSON.parse(response)
        games['data'].map do |game|
            img_url = game['box_art_url']
            img_url["{width}x{height}"] = "200x200"
            Game.find_or_create_by(tw_id: game['id'], name: game['name'], img_url: img_url)
        end
    end

    def top_clips
        response = RestClient.get "https://api.twitch.tv/helix/clips?game_id=#{self.tw_id}&first=6", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        clips = JSON.parse(response)
        broadcaster_ids = ''
        clips['data'].map do |clip| #streamer id needs to be like game id and find game
            if broadcaster_ids.empty?
                broadcaster_ids += "id=#{clip['broadcaster_id']}"
            else 
                broadcaster_ids += "&id=#{clip['broadcaster_id']}"
            end
            Clip.create(url: clip['url'], streamer_id: clip['broadcaster_id'], game_id: Game.find_by(tw_id: clip['game_id']).id, title: clip['title'], view_count: clip['view_count'], date_clipped: clip['created_at']) unless Clip.find_by(url: clip['url']).url
        end
        byebug
        response = RestClient.get "https://api.twitch.tv/helix/users?#{broadcaster_ids}", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        streamers = JSON.parse(response)
        streamers['data'].map do |streamer|
            tempstreamer = Streamer.find_or_create_by(tw_id: streamer['id'], username: streamer['display_name'], broadcaster_type: streamer['broadcaster_type'], description: streamer['description'], profile_img_url: streamer['profile_image_url'], view_count: streamer['view_count'])
            tempclip = Clip.find_by(streamer_id: streamer['id'])
            tempclip.update(streamer_id: tempstreamer.id)
        end
    end
end