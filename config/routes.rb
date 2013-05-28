Ej::Application.routes.draw do

  # root to: "static_pages#splash"
  
  get "static_pages/splash"

  get "static_pages/account"

  get "static_pages/concierge"

  get "static_pages/contact_us"

  get "static_pages/detail"

  get "static_pages/home"

  get "static_pages/listing"

  get "static_pages/queue"

  get "static_pages/signup"
  
  get "admin_pages/model"
  get "admin_pages/inventory"
  get "admin_pages/inventory_transit_to_member"
  get "admin_pages/inventory_available"
  get "admin_pages/inventory_full"
  get "admin_pages/inventory_arrange_transit"
  get "admin_pages/inventory_past_due"
  get "admin_pages/inventory_purchase_request"
  get "admin_pages/inventory_watch_record"


  authenticated :user do
    root :to => redirect("/admin/products")
    namespace :admin do
      resources :products, :users, :settings, :vendors, :tiers, :inventory, :courier_transits,
                :fedex_transits, :records, :product_images, :events
      match "products/:product_id/upload_image" => "products#upload_image"
      match "products/add_vendor" => "products#add_vendor"
      match "products/:id/add_watch" => "products#add_watch"
      match "inventory/:id/add_record" => "inventory#add_record"

    end
  end
  root :to => "users#index"
  devise_for :users
end