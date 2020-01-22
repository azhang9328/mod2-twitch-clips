class AskTwitch
    def self.update
        AskTwitch.tw_top_games.each do |game|
            game.tw_top_clips
            sleep(5)
        end
    end

    def self.tw_top_games
        response = RestClient.get 'https://api.twitch.tv/helix/games/top?first=6', {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        games = JSON.parse(response)
        games['data'].map do |game|
            img_url = game['box_art_url']
            img_url["{width}x{height}"] = "200x200"
            # Game.find_or_create_by(tw_id: game['id'], name: game['name'], img_url: img_url)
            tempgame = Game.find_by(tw_id: game['id'], name: game['name'], img_url: img_url)
            if tempgame
                tempgame.update(corf: DateTime.current)
            else 
                Game.create(tw_id: game['id'], name: game['name'], img_url: img_url, corf: DateTime.current)
            end
        end
    end

    def tw_top_clips
        response = RestClient.get "https://api.twitch.tv/helix/clips?game_id=#{self.tw_id}&first=6", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        clips = JSON.parse(response)
        broadcaster_ids = ''
        clips['data'].map do |clip|
            tempstreamer = find_or_create_streamer(clip['broadcaster_id'])
            # Clip.find_or_create_by(url: clip['url'], streamer_id: tempstreamer.id, game_id: Game.find_by(tw_id: clip['game_id']).id, title: clip['title'], view_count: clip['view_count'], date_clipped: clip['created_at'])
            tempclip = Clip.find_by(url: clip['url'], streamer_id: tempstreamer.id, game_id: Game.find_by(tw_id: clip['game_id']).id, title: clip['title'], view_count: clip['view_count'], date_clipped: clip['created_at'])
            if tempclip
                tempclip.update(corf: DateTime.current)
            else 
                Clip.create(url: clip['url'], streamer_id: tempstreamer.id, game_id: Game.find_by(tw_id: clip['game_id']).id, title: clip['title'], view_count: clip['view_count'], date_clipped: clip['created_at'], corf: DateTime.current)
            end
        end
    end

    def find_or_create_streamer(broadcaster_id)
        response = RestClient.get "https://api.twitch.tv/helix/users?id=#{broadcaster_id}", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        temp = JSON.parse(response)
        streamer = temp['data'][0]
        # Streamer.find_or_create_by(tw_id: streamer['id'], username: streamer['display_name'], broadcaster_type: streamer['broadcaster_type'], description: streamer['description'], profile_img_url: streamer['profile_image_url'], view_count: streamer['view_count'])
        tempstreamer = Streamer.find_by(tw_id: streamer['id'], username: streamer['display_name'], broadcaster_type: streamer['broadcaster_type'], description: streamer['description'], profile_img_url: streamer['profile_image_url'], view_count: streamer['view_count'])
        if tempstreamer
            tempstreamer.update(corf: DateTime.current)
        else 
            Streamer.create(tw_id: streamer['id'], username: streamer['display_name'], broadcaster_type: streamer['broadcaster_type'], description: streamer['description'], profile_img_url: streamer['profile_image_url'], view_count: streamer['view_count'], corf: DateTime.current)
        end
    end
end