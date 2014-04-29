Mule::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'main#index'
  resource :inventory
  resource :users
  resource :session
  resources :rooms, except: [:new, :edit]
  resources :pdf, defaults: { format: :pdf }, only: [:index]
  get ':id' => 'main#index'
  get ':id/:id' => 'main#index'
end
