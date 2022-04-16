class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.integer :number
      t.text :content
      t.references :chat, foreign_key: true
      t.string :app_token
      t.integer :chat_number

      t.timestamps
    end

    add_index :messages, [:app_token, :chat_number, :number], unique: true
  end
end
