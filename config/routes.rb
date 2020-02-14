Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :sale_events, controller: :events do
    get :new, as: 'new_sale_event'
    get 'edit/:event_id',to: 'sale_events#edit', as:'edit_sale_event'
    get :index, as: 'sale_events_index'
    get 'show/:event_id',to: 'sale_events#show', as:'show_sale_event'
    post :create, as: 'sale_event_inspection'
    put :update, as: 'update_sale_event'
  end
  root to: "sale_events#index"
end
