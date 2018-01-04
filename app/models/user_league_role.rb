class UserLeagueRole < ApplicationRecord
  belongs_to :user
  belongs_to :league

  validates :user_id, presence: true, uniqueness: { scope: :league_id }
  validates :league_id, presence: true
  validates :role, inclusion: { in: [0, 1] }
end
