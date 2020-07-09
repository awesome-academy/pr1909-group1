Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  scope "(:locale)", locale: /en|vi/ do
    root 'home#index'

    get "/about", to: "home#about"
    resources :courses
    resources :review_courses, except: [:new, :show]
    devise_for :users, skip: :omniauth_callbacks
    resources :users, except: [:new, :create]
    resources :lessons, only: :show
    resources :registers, only: [:edit, :update]
    resources :quiz_results, only: :create
    get "course/like/:course_id", to: "likes#save_like", as: :like_course
    resources :registers, only: :create

    namespace :admin do
      get "/", to: "base#index"
      resources :courses
      resources :users
      devise_scope :user do
        get "/login", to: "sessions#new"
        post "/login", to: "sessions#create"
        delete "/logout", to: "sessions#destroy"
      end
    end
    # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  end
  devise_for :users, only: :omniauth_callbacks, controllers: { omniauth_callbacks: "omniauth_callbacks" }
end
