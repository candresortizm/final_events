Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :sale_events, controller: :sale_events do
    get :new, as: 'new_sale_event'
    get 'edit/:event_id',to: 'sale_events#edit', as:'edit_sale_event'
    get :index, to: 'sale_events#index',as: 'sale_events_index'
    get 'show/:event_id',to: 'sale_events#show', as:'show_sale_event'
    post :create, as: 'create_sale_event'
    put :update, as: 'update_sale_event'
  end
  root "sale_events#index"
end
