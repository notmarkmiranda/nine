class Season < ApplicationRecord
  belongs_to :league
  has_many :games

  validates :league_id, presence: true

  before_create :deactivate_other_seasons

  private

  def deactivate_other_seasons
    league.seasons.update_all(active: false)
  end
end
