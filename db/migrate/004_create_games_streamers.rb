class CreateGamesStreamers < ActiveRecord::Migration[5.0]
    def change 
        create_table :games_streamers do |t|
            t.integer :game_id
            t.integer :streamer_id
        end
    end
end