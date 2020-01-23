class Clip < ActiveRecord::Base 
    belongs_to :game, optional: true
    belongs_to :streamer, optional: true
    has_one :favorite_clip
end