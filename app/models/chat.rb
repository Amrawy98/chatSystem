class Chat < ApplicationRecord
  belongs_to :app, foreign_key: :app_id, primary_key: :token
  has_many :messages, dependent: :destroy
end
