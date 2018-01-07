class GamesController < ApplicationController
  include LeagueHelper

  before_action :load_season, only: [:new, :create]
  before_action :load_game, only: [:show, :edit, :update]
  before_action :verify_part_of_league, only: [:show]
  before_action :verify_admin_for_league, except: [:show, :destroy]

  def show
  end

  def new
  end

  def create
    @game = season.games.new(game_params)
    if @game.save
      redirect_to league_season_game_path(league, season, @game)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @game.update(game_params)
      redirect_to league_season_game_path(league, season, @game)
    else
      render :edit
    end
  end

  private

  def game_params
    params.require(:game).permit(:season_id, :user_id, :attendees, :buy_in, :privated)
  end
end
