Rails.application.routes.draw do
  # ActionController::Routing::Routes.draw do |map|
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :controller => 'topics', :action => 'index'
  resources :topics, except: [:destroy] do
    resources :comments, only: [:create, :new]
    collection do
      post :new, path: :new, as: :new, action: :new
      post :confirm, to: 'topics#confirm'
      get :delete_select, to: 'topics#delete_select'
      # post :delete_select, path: :delete_select, as: :delete_back, action: :delete_back
      post :delete_confirm, to: 'topics#delete_confirm'
      delete :delete, to: 'topics#delete'
      match :search, to: 'topics#search', via: [:get, :post]
    end
    member do
      patch :edit, path: :edit, as: :edit, action: :edit
      match :confirm, to: 'topics#confirm', via: [:get, :patch]
      post :vote, to: 'topics#vote',   as: 'vote'
      post :topic_like, to: 'topics#topic_like'
      delete :topic_like, to: 'topics#topic_like_destroy'
      post :comment_like, to: 'topics#comment_like'
      delete :comment_like, to: 'topics#comment_like_destroy'
    end
  end
end
