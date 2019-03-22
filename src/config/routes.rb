Rails.application.routes.draw do
  get 'configuration/index'

  devise_for :users

  get '/users/approve/:id', to: 'users#toggle_approve', as: :toggle_approve_user
  get '/users/removable/:id', to: 'users#toggle_removable', as: :toggle_removable_user

  resources 'users'

  namespace :test_server do
    get 'file_downloads/by-label/:label', to: 'file_downloads#by_label', as: 'file_downloads_by_label'

    resources :file_downloads

    resources :meta_information, only: %i(index)

    namespace :dns_requests do
      resources :host_name, only: %i(new create)
      resources :ip_address, only: %i(new create)
    end

    namespace :reflectors do
      get :request_headers, to: 'request_headers#show'
      post :request_body, to: 'request_body#create'
      get :request_body, to: 'request_body#show'
      get :client_ip_address, to: 'client_ip_address#show'
      get :params, to: 'params#show'
    end

    get :reflectors, to: 'reflectors#index'

    namespace :streaming do
      get :plain, to: 'plain#show'
      get :eicar, to: 'eicar#show'
      get :random, to: 'random#show'
    end

    get :streaming, to: 'streaming#index'

    namespace :string do
      get :plain, to: 'plain#show'
      get :eicar, to: 'eicar#show'
      get :random, to: 'random#show'
      get :sleep, to: 'sleep#show'
    end

    get :string, to: 'string#index'

    namespace :file_uploader do
      get :upload, to: 'upload#new'
      post :upload, to: 'upload#create'
    end

    get :file_uploader, to: 'file_uploader#index'

    namespace :generator do
      get :xhr, to: 'xhr#show', format: false
    end

    get :generator, to: 'generator#index'

    resources :whois_requests, only: %i(new create)
  end

  scope module: 'test_server' do
    root 'dashboard#show'

    # match '(errors)/:exception', to: 'errors#show', constraints: {exception: /[a-z_0-9]+/}, via: :all

    get '/dashboard', to: 'dashboard#show'
    get '/static', to: 'static#index'
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

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
