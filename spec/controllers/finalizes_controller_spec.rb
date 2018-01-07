require 'rails_helper'

describe FinalizesController, type: :controller do
  context 'PATCH#update' do
    let(:user)   { create(:user) }
    let(:game)   { create(:game) }
    let(:season) { game.season }
    let(:league) { season.league }
    let(:admin)  { league.creator }
    let(:member) do
      create(:user_league_role, :member, user: user, league: league)
      user
    end

    it 'redirects to league season game path - successful update' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, game_id: game.id }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end

    it 'renders the dashboard path - member' do
      patch :update, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, game_id: game.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the dashboard path - user' do
      patch :update, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, game_id: game.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the sign in path - visitor' do
      patch :update, params: { league_slug: league.slug, season_id: season.id, game_id: game.id }

      expect(response).to redirect_to sign_in_path
    end
  end
end
