require 'rails_helper'

describe UsersController, type: :controller do
  let(:user) { create(:user) }

  context 'get#show' do
    it 'renders the show template' do
      get :show, session: { user_id: user.id }

      expect(response).to render_template :show
    end

    it 'redirects to sign in path - visitor' do
      get :show

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'get#new' do
    it 'renders the new template' do
      get :new

      expect(response).to render_template :new
    end

    it 'redirects to dashboard path - logged-in user' do
      get :new, session: { user_id: user.id }

      expect(response).to redirect_to dashboard_path
    end
  end

  context 'post#create' do
    let(:attrs) { attributes_for(:user) }

    it 'redirects to dashboard path - successful create' do
      post :create, params: { user: attrs }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the new template - unsuccessful create' do
      post :create, params: { user: attrs.except(:email) }

      expect(response).to render_template :new
    end
  end

  context 'get#edit' do
    it 'renders the edit template' do
      get :edit, session: { user_id: user.id }

      expect(response).to render_template :edit
    end

    it 'redirects to sign in path - visitor' do
      get :edit

      expect(response).to redirect_to sign_in_path
    end
  end

  context 'patch#update' do
    it 'redirects to dashboard path - successful update' do
      patch :update, session: { user_id: user.id }, params: { user: { email: 'a@b.com' } }

      expect(response).to redirect_to dashboard_path
    end

    it 'renders the edit template - unsuccessful update' do
      patch :update, session: { user_id: user.id }, params: { user: { email: '' } }

      expect(response).to render_template :edit
    end
  end
end
