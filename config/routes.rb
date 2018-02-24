Rails.application.routes.draw do

  get 'request_for_notification/:id/:id1' => 'cars#request_for_notification' ,:as => 'request_for_notification'
  get 'checkout_car' => 'bookings#checkout_car' ,:as => 'checkout_car'
  get 'member/admin_watch_user' => 'members#admin_watch_user' , :as => 'admin_watch_user'
  get 'member/admin_show_page' => 'members#admin_show_page' , :as => 'admin_stuff'
  match 'member/:id' => 'members#destroy' , :via => [:put,:get] ,:method => :delete , :as => 'member_destroy'
  match 'members' => 'members#create' , :via => :put
  resources :members
  get 'bookings/:id/edit' => 'bookings#edit' ,:as => 'edit_booking'
  get 'bookings' => 'bookings#index'
  match 'booking/:id' => 'bookings#update' ,:via => [:get,:patch],:as => 'booking'
  get 'check_out_history_car/:id' => 'bookings#check_out_history_car' , :as => 'check_out_history_car'
  match 'reserve_car/:id' => 'bookings#reserve_car', :via => [:put,:get], :as => 'reserve_car'
  match 'reserve_car/:id' => 'bookings#reserve!', :via => [:post], :as => 'reserve'
  match 'reserve_now/:id' => 'bookings#reserve_now', :via => [:post], :as => 'reserve_now'
  match 'delete_reservation/:id' => 'bookings#delete_booking', :via => [:get], :method => :delete, :as => 'delete_reservation'
  match 'reserve_car_for_user/:id' => 'bookings#reserve_car_for_user' , :via => [:get], :as => 'reserve_car_for_user'
  match 'reserve_car_for_user/:id' => 'bookings#reserve_for_user' , :via => [:put], :as => 'reserve_for_user'
  get 'show_booking_history' => 'bookings#show_booking_history' ,:as => 'show_booking_history'
  devise_for :users
  resources :cars
  root :to => 'cars#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
