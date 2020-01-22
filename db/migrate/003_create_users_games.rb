class CreateUsersGames < ActiveRecord::Migration[5.0]
    def change 
        create_table :users_games do |t|
            t.integer :user_id
            t.integer :game_id
        end
    end
end