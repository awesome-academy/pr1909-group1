Rails.application.routes.draw do
  namespace :admin do
    resource :dashboard
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
