class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_many :created_leagues, class_name: 'League', foreign_key: 'user_id'
  has_many :user_league_roles
  has_many :leagues, through: :user_league_roles do
    def member
      where('user_league_roles.role = ?', 0)
    end

    def admin
      where('user_league_roles.role = ?', 1)
    end
  end
  has_many :non_league_games, class_name: 'Game', foreign_key: :user_id

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def admin_leagues
    leagues.admin
  end

  def member_leagues
    leagues.member
  end
end
