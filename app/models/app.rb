class App < ApplicationRecord
  has_secure_token
  has_many :chats, foreign_key: :app_id, primary_key: :token, dependent: :destroy
end
