class CreateClips< ActiveRecord::Migration[5.0]
    def change 
        create_table :clips do |t|
            t.string :title
            t.string :url
            t.integer :view_count
            t.string :date_clipped
            t.integer :streamer_tw_id
            t.integer :streamer_id
            t.integer :game_id
            t.datetime :corf
        end
    end
end