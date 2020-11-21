Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'users#show'
  get 'home/top' => 'homes#top' , as: 'top'
  get 'home/about' => 'homes#about' , as: 'about'
end
