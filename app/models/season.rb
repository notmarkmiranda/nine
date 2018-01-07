class Season < ApplicationRecord
  belongs_to :league
  has_many :games

  validates :league_id, presence: true

  before_create :deactivate_other_seasons

  def activate!
    update!(active: true)
  end

  def complete!
    update!(completed: true)
  end

  def deactivate!
    update!(active: false)
  end

  def uncomplete!
    update!(completed: false)
  end

  private

  def deactivate_other_seasons
    league.seasons.update_all(active: false)
  end
end
