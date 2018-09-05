Rails.application.routes.draw do
  get 'contact' => 'contacts#new'

  get 'contacts/create'

  get 'about' => 'about#index'

  namespace :admin do
    get 'sessions/new'
    get 'sessions/create'
  end
  namespace :admin do
    get 'comments/destroy'
  end
  get 'categories/show'
  get 'posts/index'
  get 'posts/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts, :categories, :comments
  resources 'contacts', only: %i[new create]

  namespace :admin do
    resources :posts, :categories, :comments, :users, :sessions
  end

  resources :posts do
    resources :comments
  end

  root 'posts#index'
end
