require 'rails_helper'

describe GamesController, type: :controller do
  let(:user)   { create(:user) }
  let(:game)   { create(:game) }
  let(:season) { game.season }
  let(:league) { season.league }
  let(:admin)  { league.creator }
  let(:member) do
    create(:user_league_role, :member, user: user, league: league)
    user
  end

  context 'GET#show' do
    it 'renders the show template - public, visitor' do
      league.update(privated: false)
      get :show, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to render_template :show
    end

    context 'private league' do
      before do
        league.update(privated: true)
      end

      it 'renders the show template - private, admin' do
        get :show, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

        expect(response).to render_template :show
      end

      it 'renders the show template - private, member' do
        get :show, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

        expect(response).to render_template :show
      end

      it 'renders the dashboard path - private, user' do
        get :show, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects to sign in path - private, visitor' do
        get :show, params: { league_slug: league.slug, season_id: season.id, id: game.id }

        expect(response).to redirect_to sign_in_path
      end
    end
  end

  context 'GET#new' do
    it 'renders the new template - admin' do
      get :new, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to render_template :new
    end

    it 'renders the redirects to dashboard path - member' do
      get :new, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - user' do
      get :new, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      get :new, params: { league_slug: league.slug, season_id: season.id }

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:game) }

    it 'redirects to game path - successful create, admin' do
      post :create, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs }

      expect(response).to redirect_to league_season_game_path(league, season, Game.last)
    end

    it 'renders the new template - unsuccessful create, admin' do
      post :create, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs.except(:buy_in) }

      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - member' do
      post :create, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, game: attrs }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      post :create, params: { league_slug: league.slug, season_id: season.id, game: attrs }

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'GET#edit' do
    it 'renders the edit template - admin' do
      get :edit, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to render_template :edit
    end

    it 'redirects to dashboard path - member' do
      get :edit, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - user' do
      get :edit, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      get :edit, params: { league_slug: league.slug, season_id: season.id, id: game.id }

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'PATCH#update' do
    it 'redirects to league season game path - successful update, admin' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { buy_in: 225 } }

      expect(response).to redirect_to league_season_game_path(league, season, game)
    end

    it 'renders the edit template - unsuccessful update, admin' do
      patch :update, session: { user_id: admin.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { buy_in: '' } }

      expect(response).to render_template :edit
    end

    it 'redirects to dashboard path - member' do
      patch :update, session: { user_id: member.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { buy_in: 225 } }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to dashboard path - user' do
      patch :update, session: { user_id: user.id }, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { buy_in: 225 } }

      expect(response).to redirect_to dashboard_path
    end

    it 'redirects to sign in path - visitor' do
      patch :update, params: { league_slug: league.slug, season_id: season.id, id: game.id, game: { buy_in: 225 } }

      expect(response).to redirect_to sign_in_path
    end
  end
end
