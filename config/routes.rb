Rails.application.routes.draw do
  get 'static_pages/landing'

  get 'static_pages/about'

  get 'static_pages/attributions'

  resources :countdowns, only: [:show, :index, :edit, :create, :destroy]

  devise_for :users, controllers: { registrations: "registrations", sessions: "sessions" }
  devise_scope :user do
    authenticated :user do
      root 'countdowns#index'
    end
		
    unauthenticated do
      root 'devise/sessions#new'
    end
  end

  resources :users, only: [:edit, :show, :update]

  # Begin StaticPages Controller
  get '/landing', to: 'static_pages#landing_page', as: :landing
	get '/about', to: 'static_pages#about', as: :about
	get '/attributions', to: 'static_pages#attributions', as: :attributions
  # End StaticPages Controller


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
