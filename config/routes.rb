Rails.application.routes.draw do
  resources :pos do
    member do
      get 'shipments', to: 'shipments#pos_shipments' # Existing POS shipments route
    end
    collection do
      get 'dashboard', to: 'pos#dashboard', as: 'dashboard' # New POS Dashboard route
    end
  end

  resources :warehouses
  resources :products
  resources :inventories, only: [:index, :create, :destroy]

  resources :shipments, only: [:index, :new, :create, :show, :destroy] do
    post "add_item", on: :member
    delete ":id/remove_item/:item_id", to: "shipments#remove_item", as: "remove_item"
    patch "submit_shipment", to: "shipments#submit_shipment", as: "submit_shipment"
    patch "receive_shipment", to: "shipments#receive_shipment", as: "receive_shipment" # New Route
    post "scan_received_item", to: "shipments#scan_received_item", as: "scan_received_item"  # ✅ Add this
    patch "complete_shipment", to: "shipments#complete_shipment", as: "complete_shipment"
  end

  root 'warehouses#index'
  get 'nav/index'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end


