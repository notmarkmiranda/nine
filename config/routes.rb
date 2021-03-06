Rails.application.routes.draw do
  root 'pages#index'

  resources :leagues, except: [:destroy], param: :slug do
    resources :seasons, except: [:destroy] do
      resource :activate, only: [:update]
      resource :deactivate, only: [:update]
      resource :complete, only: [:update]
      resource :uncomplete, only: [:update]
      resources :games, except: [:destroy] do
        resource :finalize, only: [:update]
        resource :unfinalize, only: [:update]
      end
    end
  end

  get  '/sign-in', to: 'sessions#new', as: 'sign_in'
  post '/sign-in', to: 'sessions#create'
  get  '/sign-out', to: 'sessions#destroy', as: 'sign_out'

  get   '/users', to: 'users#index'
  get   '/sign-up', to: 'users#new', as: 'sign_up'
  post  '/sign-up', to: 'users#create'
  get   '/dashboard', to: 'users#show', as: 'dashboard'
  get   '/edit-profile', to: 'users#edit', as: 'edit_profile'
  patch '/edit-profile', to: 'users#update'
end
