Rails.application.routes.draw do
  get 'pgform/index'
  match '/request' => 'pgform#HandleRequest', via: :post
  match '/response' => 'pgform#HandleResponse', via: :post
  match '/response' => 'pgform#HandleResponse', via: :get

  root 'pgform#index'
end
