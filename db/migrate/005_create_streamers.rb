class CreateStramers< ActiveRecord::Migration[5.0]
    def change 
        create_table :streamers do |t|
            t.string :name
        end
    end
end