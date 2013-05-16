Ej::Application.routes.draw do
  authenticated :user do
    root :to => redirect("/admin/products")
    namespace :admin do
      resources :products, :users, :settings, :vendors, :tiers, :inventory, :courier_transits, :fedex_transits, :records
      match "products/add_vendor" => "products#add_vendor"
      match "products/:id/add_watch" => "products#add_watch"
      match "inventory/:id/add_record" => "inventory#add_record"
    end
  end
  root :to => "users#index"
  devise_for :users
end