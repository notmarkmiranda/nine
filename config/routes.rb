Rails.application.routes.draw do
  get   '/sign-up', to: 'users#new', as: 'sign_up'
  post  '/sign-up', to: 'users#create'

  get   '/dashboard', to: 'users#show', as: 'dashboard'

  get   '/edit-profile', to: 'users#edit', as: 'edit_profile'
  patch '/edit-profile', to: 'users#update'
end
