class Season < ApplicationRecord
  belongs_to :league

  validates :league_id, presence: true
end
