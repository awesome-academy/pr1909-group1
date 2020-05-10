Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root 'job_posts#index'

    get "/blog", to: "blog#index"
    resources :apply_activities, only: [:index, :create, :destroy]
    resources :employers
    resources :candidates
    resources :job_posts
    devise_for :users, :controllers => { registrations: "registrations" }
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
    mount Ckeditor::Engine => '/ckeditor'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
