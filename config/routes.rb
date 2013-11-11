SAAP::Application.routes.draw do

  get '/auth/:provider/callback', to: 'google_sessions#create'
  concern :importable do
    get :import, on: :collection
    post :upload, on: :collection
  end

  resource :session, only: [:new, :create, :destroy]
  resource :profile, only: [:show, :edit, :update]

  resources :crowds, concerns: [:importable] do
    resources :enunciations do
      post :clone, on: :member
    end
  end
  resource :dashboard, only: :show

  resources :groups, only: [:show, :create, :update, :destroy] do
    resources :tasks, only: [:create] do
      resources :subtasks, only: [:create]
      put :start, on: :member
      put :complete, on: :member
    end
    resources :final_repo_versions, only: :create
    resources :partial_repo_versions, only: :create
    get "tree/:tree/" => "groups#tree", on: :member, as: :tree
    get "tree/:tree/:path" => "groups#tree",
      on: :member,
      as: :tree_file,
      constraints: {
        id: /[a-zA-Z0-9_\-]+/,
        tree: /[a-zA-Z0-9_\-]+/,
        path: /.*/
      }
  end

  namespace :activity_log do
    resources :sessions
  end

  resources :professors, :students, :subjects, concerns: [:importable]
  resources :pub_keys

  namespace :messages do
    resources :topics, only: [:index, :show, :new, :create, :destroy] do
      post :approve, on: :member
      resources :messages
    end
  end

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'dashboards#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
