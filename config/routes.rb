# -*- coding: utf-8 -*-
Gaidarfund::Application.routes.draw do
  require 'subdomain'
  require 'robots_generator'

  resources :slides
  resources :projects, :only => [:index]
  resources :articles, :only => [:show]

  mount Ckeditor::Engine => '/ckeditor'
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'
  mount ExceptionLogger::Engine => "/exception_logger"

  devise_for :users

  get '/robots.txt' => RobotsGenerator
  get "/public.php" => "articles#show_old_publication"
  get "/news.php" => "articles#show_old_news"
  get "/calendar.php" => "articles#show_old_announce"

  get "/articles/" => "articles#list", :as => 'articles', :defaults => { :format => 'json' }
  get "/publications/" => "articles#publications", :as => 'publications'
  get "/search/" => "application#search", :as => 'search'

  Articletype.where("slug != ''").each do |type|
    get type.slug => "articles#articles_by_type", :as => type.code, :slug => type.slug
  end
  get 'memories_3goda_bez' => "articles#memories_3goda_bez"

  constraints(Subdomain) do
    get  "/" => "projects#show"
    get "/subscribe/" => "lectures#subscribe", :as => 'events_subscribe'
  end
  root :to => "application#index"

  get "/:slug/" => "pages#show"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end