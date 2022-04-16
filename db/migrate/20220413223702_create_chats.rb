class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.integer :number
      t.integer :message_count, default: 0
      t.string  :app_id
      t.integer :last_message_number, default: 0
    
      t.timestamps
    end

    add_index :chats, [:app_id ,:number], unique: true
  end
end
