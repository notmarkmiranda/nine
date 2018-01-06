class LeaguesController < ApplicationController
  include LeagueHelper

  before_action :load_league, except: [:new, :create]
  before_action :require_user, only: [:new, :create]

  before_action :verify_part_of_league, only: [:show]
  before_action :verify_admin_for_league, only: [:edit, :update]

  def show
  end

  def new
    @league = League.new
  end

  def create
    @league = current_user.created_leagues.new(league_params)
    if @league.save
      redirect_to @league
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @league.update(league_params)
      redirect_to @league
    else
      render :edit
    end
  end

  private

  def league_params
    params.require(:league).permit(:name, :privated)
  end
end
