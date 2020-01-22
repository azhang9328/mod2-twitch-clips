class Streamer < ActiveRecord::Base 
    has_many :clips 
    has_many :games, through: :clips
end