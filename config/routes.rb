Rails.application.routes.draw do
  # ActionController::Routing::Routes.draw do |map|
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :controller => 'topics', :action => 'index'
  resources :topics, except: [:destroy] do
    resources :votes, only: [:create]
    resources :comments, only: [:create, :new] do
      collection do
        post :new, path: :new, as: :new, action: :new
        match :confirm, to: 'comments#confirm', via: [:get, :post]
      end
    end
    collection do
      post :new, path: :new, as: :new, action: :new
      post :confirm, to: 'topics#confirm'
      get :delete_select, to: 'topics#delete_select'
      post :delete_confirm, to: 'topics#delete_confirm'
      delete :delete, to: 'topics#delete'
    end
    member do
      patch :edit, path: :edit, as: :edit, action: :edit
      match :confirm, to: 'topics#confirm', via: [:get, :patch]
      post :like, to: 'topics#like'
      delete :like, to: 'topics#like_delete'
      post :comment_like, to: 'topics#comment_like'
      delete :comment_like, to: 'topics#comment_like_delete'
    end
  end
end
