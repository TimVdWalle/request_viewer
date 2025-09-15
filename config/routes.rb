# config/routes.rb
Rails.application.routes.draw do
  # Root
  root "pages#home"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Action Cable (needed for Hotwire LiveReload and any websockets)
  mount ActionCable.server => "/cable"

  # Bin creation + overview
  resources :bins, only: [:new, :create]
  get "/bins/:slug", to: "bins#overview", as: :bin_overview

  # Request capture endpoint at top-level: http://localhost:3000/:slug
  # Exclude reserved paths so we don't swallow Rails internals/assets.
  constraints slug: /(?!rails|cable|assets|packs|vite|bin|bins|up|manifest|service-worker|favicon\.ico|robots\.txt)[A-Za-z0-9\-]+/ do
    match "/:slug", to: "bin_ingress#receive", via: [:get, :post], as: :bin_receive
  end

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
end
