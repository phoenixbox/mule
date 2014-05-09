Mule::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  root 'main#one'

  get '/residence-type' => 'main#two'
  get '/move-service-type' => 'main#three'
  get '/addresses' => 'main#four'

  resource :inventory
  resource :users
  resource :session
  resources :rooms, except: [:new, :edit]
  resources :pdf, defaults: { format: :pdf }, only: [:index]
  get ':id' => 'main#one'
  get ':id/:id' => 'main#one'
end
