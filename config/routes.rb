Refinery::Core::Engine.routes.draw do
  get 'blog/most_popular', to: "blog/posts#most_popular"
  get "signup", to: "pages#signup", as: :signup_page
end

Rails.application.routes.draw do
  resources :orders, only: [:edit, :update]
  get 'pricing', to: 'orders#edit', as: :pricing_page
  patch 'agree_to_terms', to: 'orders#agree_to_terms', as: :agree_to_terms
  patch 'reset_order', to: 'orders#reset_order', as: :reset_order

  resources :order_items, only: [:edit, :create, :update]

  resources :brief_requests, only: [:update]

  resources :charges, only: [:new, :create] do
    get :bitpay, on: :collection
    get :bitpay_callback, on: :collection
  end

  get 'checkout', to: 'charges#new', as: :checkout_page

  # post 'create_contact', to: 'static_pages#create_contact', as: :create_contact

  get 'media', to: 'static_pages#media', as: :media_page
  get 'service-agreement', to: 'static_pages#service_agreement', as: :service_agreement_page

  post 'contact/submit', to: 'contact_form#submit'

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the
  # configuration option `mounted_path` to something different in config/initializers/refinery/core.rb
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"

  match '*path', via: :all, to: 'errors#not_found', constraints: CloudfrontConstraint.new

  mount Refinery::Core::Engine, at: Refinery::Core.mounted_path
  # require 'sidekiq/web'
  # authenticate :user, lambda { |u| u.is_admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end
end
