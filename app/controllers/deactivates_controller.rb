class DeactivatesController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league
  before_action :load_season

  def update
    @season.deactivate!
    redirect_to league_season_path(@league, @season)
  end
end
