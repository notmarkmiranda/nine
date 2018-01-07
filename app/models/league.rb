class League < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :user_league_roles
  has_many :users, through: :user_league_roles do
    def admins
      where('user_league_roles.role = ?', 1)
    end

    def members
      where('user_league_roles.role = ?', 0)
    end
  end
  has_many :seasons

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :user_id, presence: true

  before_validation :set_slug
  after_create :create_admin_ulr
  after_create :create_initial_season

  def admins
    users.admins
  end

  def members
    users.members
  end

  def not_part_of_league?(user)
    !part_of_league?(user)
  end

  def not_privated?
    !privated?
  end

  def part_of_league?(user)
    users.include?(user)
  end

  def privated_slogan
    privated? ? 'Private League' : 'Public League'
  end

  def to_param
    self.slug if slug
  end

  private

  def create_admin_ulr
    user_league_roles.create!(user: creator, role: 1)
  end

  def create_initial_season
    seasons.create!
  end

  def set_slug
    self.slug = name.parameterize if should_change_name?
  end

  def should_change_name?
    !name.blank?
  end
end
