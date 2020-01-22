class Clip < ActiveRecord::Base 
    belongs_to :game
    belongs_to :streamer
end