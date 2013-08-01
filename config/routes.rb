Ej::Application.routes.draw do
  # root to: "static_pages#splash"


  get "static_pages/splash"

  get "static_pages/account"

  get "static_pages/concierge"

  #get "static_pages/contact_us"

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
  get "admin_pages/members"
  get "admin_pages/member_individual"

  match '/ipn' => 'ipn#index'
  post '/admin/members/approval'
  resources :fedex_transits

  namespace :admin do
    post 'signin' => 'login#signin'
    match 'login' => 'login#index'
    match 'products/add_product' => 'products#add_product'
    match 'search_prospect' => 'members#search_prospect'
    match 'prospect_invitation' => 'members#prospect_invitation', :as => :prospect_invitation
    match 'prospects' => 'members#prospects'
    match 'page_members' => 'members#page_members'
    match 'page_member_que' => 'members#page_member_que'
    match 'page_member_rotation_history' => 'members#page_member_rotation_history'
    match "products/:product_id/upload_image" => "products#upload_image"
    match "products/add_vendor" => "products#add_vendor"
    match "products/:id/add_inventory" => "products#add_inventory"
    match "products/add_option" => "products#add_option"
    match 'products/reorder_images' => 'products#reorder_images'
    match "selection/get_pairs" => "selection#get_pairs"
    match "selection/distribute" => "selection#distribute"
    #match "products" => redirect("/admin/products/")
    match 'inventory/remove_record' => 'inventory#remove_record'
    match 'inventory/add_service/:id' => 'inventory#add_service'
    match 'inventory/status/:id' => 'inventory#status'
    match 'inventory/change_transit/:id' => 'inventory#change_transit'
    match 'admins/add_role' => 'admins#add_role'
    match 'admins/remove_role' => 'admins#remove_role'
    match 'shipping/pickup' => 'shipping#pickup'
    match 'shipping/cancel_pickup' => 'shipping#cancel_pickup'
    match 'shipping/mark_delivered' => 'shipping#mark_delivered'
    ['inventory','products', 'shipping', 'selection'].each do |path|
      controller = ('Admin::'+path.capitalize+'Controller').constantize
      controller.tabs.each do |a, l|
        action = a.to_s
        match path+'/'+action => path+"#"+action
      end
    end

    resources :products, :users, :settings, :vendors, :tiers, :courier_transits,
              :records, :product_images, :events, :inventory, :selection, :storage_records, :services,
              :rotations, :admins, :shipping, :members

  end


  match "/request_product" => 'users#request_product'
  delete "/delete_request" => 'users#delete_request'
  match "/fedex-email-notifications" => 'fedex_transits#update'
  root :to => "home#collection"
  devise_for :users, :controllers => {:registrations => "registrations"} do
    match '/auth/sign_out' => 'registrations#destroy_session', :as => :destroy_user_session
    post '/users/sign_in' => 'sessions#create'
  end

  get '/home' => 'home#home_index', :as => :home
  get 'collection/:id' => 'products#show', :as => :show_collection
  get 'collection' => 'home#collection'
  post 'comment' => 'products#comment', :as => :add_comment
  post 'comment_helpful' => 'products#comment_helpful'
  post 'filter_collection' => 'home#filter_collection'
  get 'user_queue' => 'home#user_queue'

  get '/service_benefits' => 'home#service_benefits', :as => :service_benefits

  get '/contact' => 'home#contact', :as => :contact
  post '/save_contact' => 'home#save_contact', :as => :save_contact
  get 'my_account' => 'users#my_account', :as => :my_account
  put 'update_account' => 'users#update_account', :as => :update_account
  post 'add_referral' => 'users#add_referral', :as => :add_referral
  post 'add_shipping_address' => 'users#add_shipping_address', :as => :add_shipping_address
  post 'selected_shipping' => 'users#selected_shipping', :as => :selected_shipping
  post 'rental_months' => 'users#rental_months', :as => :rental_months
  match '*path' => redirect("/users/sign_in")
end