Rails.application.routes.draw do
 
  get 'welcome/index'

  resources :articles
   resources :price
  root 'welcome#index'
end
