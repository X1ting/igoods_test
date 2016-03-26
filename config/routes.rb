Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', user: 'users' }
  devise_scope :user do
    get '/user/articles', to: 'users#articles'
    get '/user/comments', to: 'users#comments'
  end
  root 'articles#index'
  resources :articles do
    resources :comments, only: [:create, :update, :destroy, :edit]
  end
end
