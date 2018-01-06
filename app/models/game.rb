class Game < ApplicationRecord
  belongs_to :season
  belongs_to :creator, class_name: 'User', foreign_key: :user_id

  validates :attendees, presence: true
  validates :buy_in, presence: true
end
