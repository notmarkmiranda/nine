class UnfinalizesController < ApplicationController
  include LeagueHelper

  before_action :verify_admin_for_league
  before_action :load_game

  def update
    @game.unfinalize!
    redirect_to league_season_game_path(league, season, @game)
  end
end
