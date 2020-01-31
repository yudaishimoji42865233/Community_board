Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'topics#index'
  resources :topics do
    resources :comments, only: [:create, :new]
    collection do
      post :new_confirm, to: 'topics#new_confirm'
      post :new, path: :new, as: :new, action: :new_back
      get :delete_select, to: 'topics#delete_select'
      post :delete_select, path: :delete_select, as: :delete_back, action: :delete_back
      post :delete_confirm, to: 'topics#delete_confirm'
      delete :delete, to: 'topics#delete'
      get :show2, to: 'topics#show2'
      get :show3, to: 'topics#show3'
      match :search, to: 'topics#search', via: [:get, :post]
    end
    member do
      post :vote, to: 'topics#vote',   as: 'vote'
      post :topic_like, to: 'topics#topic_like'
      delete :topic_like, to: 'topics#topic_like_destroy'
      post :comment_like, to: 'topics#comment_like'
      delete :comment_like, to: 'topics#comment_like_destroy'
    end
  end
end
