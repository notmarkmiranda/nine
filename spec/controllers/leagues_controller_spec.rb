require 'rails_helper'

describe LeaguesController, type: :controller do
  let(:user) { create(:user) }
  context 'GET#show' do
    context 'public' do
      let(:public_league) { create(:league, :public) }
      let(:public_admin)  { public_league.creator }
      let(:public_member) do
        create(:user_league_role, :member, user: user, league: public_league)
        user
      end

      it 'renders the show template - public league, visitor' do
        get :show, params: { slug: public_league.slug }

        expect(response).to render_template :show
      end

      it 'renders the show template - public league, member' do
        get :show, session: { user_id: public_member.id }, params: { slug: public_league.slug }

        expect(response).to render_template :show
      end

      it 'renders the show template - public league, admin' do
        get :show, session: { user_id: public_admin.id }, params: { slug: public_league.slug }

        expect(response).to render_template :show
      end
    end

    context 'private' do
      let(:private_league) { create(:league, :private) }
      let(:private_admin)  { private_league.creator }
      let(:private_member) do
        create(:user_league_role, :member, user: user, league: private_league)
        user
      end

      it 'renders the show template - private league, member' do
        get :show, session: { user_id: private_member.id }, params: { slug: private_league.slug }

        expect(response).to render_template :show
      end

      it 'renders the show template - private league, admin' do
        get :show, session: { user_id: private_admin.id }, params: { slug: private_league.slug }

        expect(response).to render_template :show
      end

      it 'redirects to dashboard path - private league, non-member' do
        get :show, session: { user_id: user.id }, params: { slug: private_league.slug }

        expect(response).to redirect_to dashboard_path
      end
    end
  end

  context 'GET#new' do
    it 'renders the new template - user' do
      get :new, session: { user_id: user.id }

      expect(response).to render_template :new
    end

    it 'redirects to sign in path' do
      get :new

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'POST#create' do
    let(:attrs) { attributes_for(:league) }

    it 'redirects to league path - successful create, user' do
      post :create, session: { user_id: user.id }, params: { league: attrs }

      expect(response).to redirect_to league_path(League.last)
    end

    it 'renders the new template - unsuccesssful create, user' do
      post :create, session: { user_id: user.id }, params: { league: attrs.except(:name) }

      expect(response).to render_template :new
    end

    it 'redirects to sign in path - visitor' do
      post :create, params: { league: attrs }

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'edit & update' do
    let(:league) { create(:league) }
    let(:admin)  { league.creator }
    let(:member) do
      create(:user_league_role, :member, league: league, user: user)
      user
    end

    context 'GET#edit' do
      it 'renders the edit template - admin' do
        get :edit, session: { user_id: admin.id }, params: { slug: league.slug }

        expect(response).to render_template :edit
      end

      it 'redirects to dashboard path - member' do
        get :edit, session: { user_id: member.id }, params: { slug: league.slug }

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects to dashboard path - user' do
        get :edit, session: { user_id: user.id }, params: { slug: league.slug }

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects to sign in path - visitor' do
        get :edit, params: { slug: league.slug }

        expect(response).to redirect_to sign_in_path
      end
    end

    context 'PATCH#update' do
      it 'redirects to league path - successful udpate, admin' do
        patch :update, session: { user_id: admin.id }, params: { slug: league.slug, league: { name: 'new name' } }

        expect(response).to redirect_to league_path(league.reload)
      end

      it 'renders the edit template - unsuccessful udpate, admin' do
        patch :update, session: { user_id: admin.id }, params: { slug: league.slug, league: { name: '' } }

        expect(response).to render_template :edit
      end

      it 'redirects to dashboard path - member' do
        patch :update, session: { user_id: member.id }, params: { slug: league.slug, league: { name: 'new name' } }

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects to dashboard path - user' do
        patch :update, session: { user_id: user.id }, params: { slug: league.slug, league: { name: 'new name' } }

        expect(response).to redirect_to dashboard_path
      end

      it 'redirects to sign in path - visitor' do
        patch :update, params: { slug: league.slug, league: { name: 'new name' } }

        expect(response).to redirect_to sign_in_path
      end
    end
  end
end
