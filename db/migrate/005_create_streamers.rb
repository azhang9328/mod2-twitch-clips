class CreateStreamers< ActiveRecord::Migration[5.0]
    def change 
        create_table :streamers do |t|
            t.string :username
            t.integer :tw_id
            t.string :broadcaster_type
            t.string :description
            t.string :profile_img_url
            t.integer :view_count
        end
    end
end