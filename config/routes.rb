Mule::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'main#index'

  resource :inventory, only: [:show]
  resource :summary, only: [:show]
  resource :users, only: [:show, :create, :update]
  resource :session, only: [:create, :destroy]
  resources :rooms, except: [:new, :edit]
  resources :pdf, defaults: { format: :pdf }, only: [:index]

  # catch all loose routes and send to backbone
  get ':id' => 'main#index'
  get ':id/:id' => 'main#index'
end