class UncompletesController < ApplicationController
  include LeagueHelper

  before_action :load_season
  before_action :verify_admin_for_league

  def update
    @season.uncomplete!
    redirect_to league_season_path(league, @season)
  end
end

