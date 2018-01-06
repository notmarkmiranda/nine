class SeasonsController < ApplicationController
  include LeagueHelper

  before_action :load_league, only: [:create]
  before_action :load_season, only: [:show]
  before_action :verify_admin_for_league, only: [:create]
  before_action :verify_part_of_league, only: [:show]

  def show
  end

  def create
    @league.seasons.create!
    redirect_to @league
  end
end
