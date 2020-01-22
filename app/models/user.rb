class User < ActiveRecord::Base
    has_many :users_games 
    has_many :games, through: :users_games

    has_secure_password
    validates :username, presence: true 
    validates :password, presence: true 
end