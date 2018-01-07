require 'rails_helper'

describe DeactivatesController, type: :controller do
  let(:user)   { create(:user) }
  let(:league) { create(:league) }
  let(:season) { league.seasons.first }
  let(:admin)  { league.creator }
  let(:member) do
    create(:user_league_role, :member, user: user, league: league)
    user
  end

  context 'PATCH#update' do
    it 'redirects to league season path - successful update' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to league_season_path(league, season)
    end

    it 'redirects to dashboard path - member' do
      patch :update, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - user' do
      patch :update, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      patch :update, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to sign_in_path
    end
  end
end
