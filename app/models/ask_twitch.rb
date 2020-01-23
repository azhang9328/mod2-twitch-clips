class AskTwitch
    def self.update_db
        AskTwitch.tw_top_games.each do |game|
            AskTwitch.tw_top_clips(game.tw_id)
            sleep(1)
        end
    end

    def self.tw_top_games
        response = RestClient.get 'https://api.twitch.tv/helix/games/top?first=6', {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        games = JSON.parse(response)
        games['data'].map do |game|
            img_url = game['box_art_url']
            img_url["{width}x{height}"] = "200x200"
            tempgame = Game.find_by(tw_id: game['id'])
            sleep(1)
            if tempgame != nil
                tempgame.update(corf: DateTime.current)
                tempgame
            else 
                Game.create(tw_id: game['id'], name: game['name'], img_url: img_url, corf: DateTime.current)
            end
        end
    end

    def self.tw_top_clips(game_id)
        response = RestClient.get "https://api.twitch.tv/helix/clips?game_id=#{game_id}&first=6", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        clips = JSON.parse(response)
        sleep(1)
        broadcaster_ids = ''
        clips['data'].map do |clip|
            tempclip = Clip.find_by(url: clip['url'], title: clip['title'])
            sleep(1)
            if tempclip != nil
                tempfavclip = FavoriteClip.find_by(clip_id: tempclip.id)
                tempfavclip.update(view_count: clip['view_count'], corf: DateTime.current) unless tempfavclip.nil?
                sleep(1)
                tempclip.update(corf: DateTime.current)
                sleep(1)
            else 
                tempstreamer = AskTwitch.find_or_create_streamer(clip['broadcaster_id'])
                sleep(1)
                tempgame = Game.find_by(tw_id: clip['game_id'])
                sleep(1)
                puts "---before check streamer: #{tempstreamer} game: #{tempgame}"
                if tempstreamer == nil 
                    tempstreamer = AskTwitch.find_or_create_streamer(clip['broadcaster_id'])
                end
                tempclip = Clip.create(url: clip['url'], title: clip['title'], view_count: clip['view_count'], date_clipped: clip['created_at'], corf: DateTime.current)
                sleep(1)
                puts "---after check streamer: #{tempstreamer} game: #{tempgame}"
                tempclip.update(streamer_id: tempstreamer.id, game_id: tempgame.id)
            end
        end
    end

    def self.find_or_create_streamer(broadcaster_id)
        response = RestClient.get "https://api.twitch.tv/helix/users?id=#{broadcaster_id}", {'Client-ID': "zjedi22l11dd49v9mymr6vw9kmlbow"}
        temp = JSON.parse(response)
        sleep(1)
        streamer = temp['data'][0]
        tempstreamer = Streamer.find_by(tw_id: streamer['id'])
        puts "---find or create streamer: #{tempstreamer}"
        if tempstreamer.nil? 
            Streamer.create(tw_id: streamer['id'], username: streamer['display_name'], broadcaster_type: streamer['broadcaster_type'], description: streamer['description'], profile_img_url: streamer['profile_image_url'], view_count: streamer['view_count'])
        end
    end
end

#game ["tw_id", 33214] streamer [["tw_id", 82524912] clip id 10