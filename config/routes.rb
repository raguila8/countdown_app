Rails.application.routes.draw do

  resources :countdowns, only: [:show, :index, :edit, :create, :destroy, :new, :update]
  get '/countdowns/new/next', to: 'countdowns#next', as: :next
  get '/countdowns/new/preview', to: 'countdowns#preview', as: :preview

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
  get '/landing', to: 'static_pages#landing', as: :landing
	get '/about', to: 'static_pages#about', as: :about
	get '/attributions', to: 'static_pages#attributions', as: :attributions
  get '/random', to: 'static_pages#random', as: :random
  # End StaticPages Controller


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
