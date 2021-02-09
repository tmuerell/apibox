Rails.application.routes.draw do
  resources :certificates
  resources :requests do
    member do
      post :run
    end
  end
  resources :folders
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
