class CreateGames < ActiveRecord::Migration[5.0]
    def change 
        create_table :games do |t|
            t.string :name
            t.string :img_url
            t.integer :tw_id
        end
    end
end