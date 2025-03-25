Rails.application.routes.draw do
  resources :pos do
  member do
    get 'shipments', to: 'shipments#pos_shipments' # ✅ Existing POS shipments route
    get 'inventory', to: 'pos_inventories#index', as: 'inventory_po' # ✅ POS Inventory view
    post 'inventory/add', to: 'pos_inventories#create', as: 'inventory_add_po' # ✅ Adding products to inventory
  end
  collection do
    get 'dashboard', to: 'pos#dashboard', as: 'dashboard' # ✅ POS Dashboard route
  end
end

  resources :warehouses
  resources :products

  resources :inventories, only: [:index, :create, :destroy]

  resources :inventories, only: [:index, :create, :destroy] # ✅ New controller for POS Inventory

  resources :shipments, only: [:index, :new, :create, :show, :destroy] do
    post "add_item", on: :member
    delete ":id/remove_item/:item_id", to: "shipments#remove_item", as: "remove_item"
    patch "submit_shipment", to: "shipments#submit_shipment", as: "submit_shipment"
    patch "receive_shipment", to: "shipments#receive_shipment", as: "receive_shipment"
    post "scan_received_item", to: "shipments#scan_received_item", as: "scan_received_item"
    patch "complete_shipment", to: "shipments#complete_shipment", as: "complete_shipment"
  end

  root 'nav#index'
  #get 'nav/index'

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
