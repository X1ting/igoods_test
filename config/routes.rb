Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations', user: 'users' }
  devise_scope :user do
    get '/user/articles', to: 'users#articles'
  end
  root 'articles#index'
  resources :articles
end
