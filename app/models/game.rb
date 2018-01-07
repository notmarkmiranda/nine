class Game < ApplicationRecord
  belongs_to :season
  belongs_to :creator, class_name: 'User', foreign_key: :user_id, optional: true

  validates :attendees, presence: true
  validates :buy_in, presence: true

  def finalize!
    update!(finalized: true)
  end

  def unfinalize!
    update!(finalized: false)
  end
end
