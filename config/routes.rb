Rails.application.routes.draw do

  get 'bookmarks/create'
  get 'bookmarks/destroy'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'homes#top'
  get 'home/about' => 'homes#about' , as: 'about'
  devise_for :users
  resources :users do
  get :search, on: :collection
  end
  resources :photos
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
  get 'user/follows/:id' => 'relationships#follows', as: 'follows'
  get 'user/followers/:id'=> 'relationships#followers', as: 'followers'

  resources :photos do
    resources :favorites,only: [:create, :destroy]
    resources :photo_comments,only: [:create, :destroy]
  end
  resources :photos, shallow: true do
    resource :bookmarks, only: %i[create destroy]
    get :bookmarks, on: :collection
  end
end
