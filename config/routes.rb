Rails.application.routes.draw do

  resources :tenants
  resources :providers
  devise_for :users, :controller => "user_registrations"

  devise_scope :user do

    get 'tenant/sign_up' => 'user_registrations#new', :user => { :meta_type => 'tenant'}
    get 'provider/sign_up' => 'user_registration#new', :user => {:meta_type => 'provider'}
  end

root 'home#index'



end
