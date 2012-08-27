require 'resque/server'
SocialWeb::Application.routes.draw do
  #devise_for :users


  get "accounts/index"
  get "admin/index"
  
  root :to => "home#index"
  match ':controller(/:action(/:id(.:format)))'
  mount Resque::Server.new, :at => "/resque"
  
  devise_for :users, :controllers => { :registrations => "registrations",
                                       :sessions => "sessions" }
end
