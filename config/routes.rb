Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'topics#index'
  resources :topics do
    collection do
      get :delete_select, to: 'topics#delete_select'
      get :delete_check, to: 'topics#delete_check'
      get :show2, to: 'topics#show2'
      get :show3, to: 'topics#show3'
    end
    member do
      get :comment_new, to: 'topics#comment_new'
    end
  end
  resources :categories, only: :show do
  end
end
