class Clip < ActiveRecord::Base 
    belongs_to :game
    belongs_to :streamer

    def top_clips
        response = RestClient.get "https://api.twitch.tv/helix/users?id=#{self.streamer_id}6", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        clips = JSON.parse(response)
        clips['data'].map do |clip| #streamer id needs to be like game id and find game
            Clip.find_or_create_by(url: clip['url'], streamer_id: clip['broadcaster_id'], game_id: Game.find_by(tw_id: clip['game_id']).id, title: clip['title'], view_count: clip['view_count'], date_clipped: clip['created_at'])
        end
    end
end