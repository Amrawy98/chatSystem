class CreateApps < ActiveRecord::Migration[5.2]
  def change
    create_table :apps do |t|
      t.string :token
      t.string :name
      t.integer :chats_count, default: 0
      t.integer :last_chat_number, default: 0

      t.timestamps
    end
    add_index :apps, :token, unique: true
  end
end
