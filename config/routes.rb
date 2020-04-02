Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :v1 do
    resources :road_routes, only: %i[index] do
      get 'road_route_points'
    end
    resources :road_route_points, only: %i[create]
  end
end
