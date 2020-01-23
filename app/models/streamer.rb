class Streamer < ActiveRecord::Base 
    has_many :clips 
    has_many :games, through: :clips
    has_many :favorite_clips
end