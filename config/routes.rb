Rails.application.routes.draw do
  resources :request_logs
  resources :request_examples do
    member do
      post :run
    end
  end
  resources :request_headers
  resources :request_params
  resources :certificates
  resources :requests do
    member do
      post :run
      get :log
    end
  end
  resources :folders

  root to: "folders#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
