Rails.application.routes.draw do

  devise_for :user, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  scope :sale_events, controller: :sale_events do
    get :new, as: 'new_sale_event'
    get 'edit/:event_id',to: 'sale_events#edit', as:'edit_sale_event'
    get :index, to: 'sale_events#index',as: 'sale_events_index'
    get 'show/:event_id',to: 'sale_events#show', as:'show_sale_event'
    post :create, as: 'create_sale_event'
    put :update, as: 'update_sale_event'
  end

  scope :reservations, controller: :reservations do
    post :create, as: 'create_reservation'
    get :index, as: 'reservations_index'
  end

  root "sale_events#index"
end
