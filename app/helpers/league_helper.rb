module LeagueHelper
  def load_league
    league
  end

  def league
    @league ||= League.find_by(slug: league_param)
  end

  def verify_admin_for_league
    return redirect_to sign_in_path if current_user.nil?
    redirect_to dashboard_path unless league.admins.include?(current_user)
  end

  def verify_part_of_league
    redirect_to dashboard_path if league.privated? && (current_user && !league.users.include?(current_user))
  end

  private

  def league_param
    controller_name == 'leagues' ? params[:slug] : params[:league_slug]
  end
end
