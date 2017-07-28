Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 root 'welcomes#index'


 resources :jobs do
   collection do
     get :search
   end
  resources :resumes
 end

 namespace :admin do
   resources :jobs do
    resources :resumes
   end
 end

 namespace :account do
   resources :jobs
 end

 resources :jobs do
    put :favorite, on: :member
  end
  resources :favorites

end
