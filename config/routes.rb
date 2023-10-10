Rails.application.routes.draw do
  devise_for :users, contollers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  devise_scope :user do
    root 'users/sessions#new'
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :books
  # devise_forで生成されないルート(一覧と詳細)
  resources :users, only: [:index, :show]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
