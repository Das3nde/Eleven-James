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
  get "admin_pages/model_removal_error"
  get "admin_pages/model_add_vendor"
  get "admin_pages/model_edit_vendor"
  get "admin_pages/model_add_photo"
  get "admin_pages/inventory"
  get "admin_pages/inventory_transit_to_member"
  get "admin_pages/inventory_available"
  get "admin_pages/inventory_full"
  get "admin_pages/inventory_arrange_transit"
  get "admin_pages/inventory_past_due"
  get "admin_pages/inventory_purchase_request"
  get "admin_pages/inventory_watch_record"


  resources :fedex_transits
  authenticated :user do
    root :to => redirect("/admin/models")
    namespace :admin do
      match "products/:product_id/upload_image" => "products#upload_image"
      match "products/add_vendor" => "products#add_vendor"
      match "products/:id/add_inventory" => "products#add_inventory"
      match "inventory/:id/add_record" => "inventory#add_record"
      match "models" => "products#models"
      match "products/featured" => "products#featured"
      match "products/new_arrivals" => "products#new_arrivals"
      match "products/popular" => "products#popular"

      resources :products, :users, :settings, :vendors, :tiers, :inventory, :courier_transits,
                :records, :product_images, :events

    end
  end
  match "/fedex-email-notifications" => 'fedex_transits#update'
  root :to => "users#index"
  devise_for :users, :controllers => {:registrations => "registrations"} do
    match '/auth/sign_out' => 'registrations#destroy_session', :as => :destroy_user_session
  end

  get 'collection' => 'home#collection'
end