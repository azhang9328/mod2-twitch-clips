class FavoriteClip < ActiveRecord::Base 
    belongs_to :game, optional: true
    belongs_to :streamer, optional: true
    belongs_to :user
    belongs_to :clip
end