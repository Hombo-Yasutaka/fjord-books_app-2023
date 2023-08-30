Rails.application.routes.draw do
  devise_for :users, contollers: { registrations: 'users/registrations'}
  resources :books
  # devise_forで生成されないルート(一覧と詳細)
  resources :users, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
