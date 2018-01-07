module LeagueHelper
  def load_league
    league
  end

  def load_season
    league
    season
  end

  def load_game
    league
    season
    game
  end

  def league
    @league ||= League.find_by(slug: league_param)
  end

  def season
    @season ||= Season.find(season_param)
  end

  def game
    @game ||= Game.find(game_param)
  end

  def verify_admin_for_league
    return redirect_to sign_in_path if current_user.nil?
    redirect_to dashboard_path unless league.admins.include?(current_user)
  end

  def verify_part_of_league
    if league.privated?
      return redirect_to sign_in_path if current_user.nil?
      redirect_to dashboard_path if !league.users.include?(current_user)
    end
  end

  private

  def league_param
    controller_name == 'leagues' ? params[:slug] : params[:league_slug]
  end

  def season_param
    controller_name == 'seasons' ? params[:id] : params[:season_id]
  end

  def game_param
    controller_name == 'games' ? params[:id] : params[:game_id]
  end
end
