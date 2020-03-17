Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root 'welcomes#index'
 resources :users do
 	resources :questions 
 end
 resources :questions, only:[] do
 	resources :answers 
 end
 resources :questions, only:[] do
 	resources :comments 
 end 
 resources :answers, only:[] do
 	resources :comments 
 end 
end
