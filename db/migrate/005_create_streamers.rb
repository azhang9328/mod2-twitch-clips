class CreateStreamers< ActiveRecord::Migration[5.0]
    def change 
        create_table :streamers do |t|
            t.string :username
            t.integer :tw_id
        end
    end
end