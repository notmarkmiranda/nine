require 'rails_helper'

describe SeasonsController, type: :controller do
  let(:season) { create(:season, active: true) }
  let(:league) { season.league }
  let(:admin)  { league.creator }
  let(:user)   { create(:user) }
  let(:member) do
    create(:user_league_role, :member, league: league, user: user)
    user
  end

  context 'GET#show' do
    it 'renders the show template - public, visitor' do
      league.update(privated: false)
      get :show, params: { league_slug: league.slug, id: season.id }

      expect(response).to render_template :show
    end

    it 'redirects to sign in path - private, visitor' do
      league.update(privated: true)
      get :show, params: { league_slug: league.slug, id: season.id }

      expect(response).to redirect_to sign_in_path
    end
  end
  context 'POST#create' do

    it 'redirects to the league show path and deactivates the other leagues' do
      post :create, session: { user_id: admin.id }, params: { league_slug: league.slug }

      expect(response).to redirect_to league_path(league)
      expect(season.reload.active).to be false
    end

    it 'redirects to dashboard path - user' do
      post :create, session: { user_id: user.id }, params: { league_slug: league.slug }

      expect(response).to redirect_to dashboard_path
    end
    it 'redirects to dashboard path - member' do
      post :create, session: { user_id: member.id }, params: { league_slug: league.slug }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      post :create, params: { league_slug: league.slug }

      expect(response).to redirect_to sign_in_path
    end
  end
end
