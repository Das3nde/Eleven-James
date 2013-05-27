Ej::Application.routes.draw do
  resources :fedex_transits
  authenticated :user do
    root :to => redirect("/admin/products")
    namespace :admin do
      resources :products, :users, :settings, :vendors, :tiers, :inventory, :courier_transits,
                :records, :product_images, :events
      match "products/:product_id/upload_image" => "products#upload_image"
      match "products/add_vendor" => "products#add_vendor"
      match "products/:id/add_watch" => "products#add_watch"
      match "inventory/:id/add_record" => "inventory#add_record"

    end
  end
  match "/fedex-email-notifications" => 'fedex_transits#update'
  root :to => "users#index"
  devise_for :users
end