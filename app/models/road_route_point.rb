class RoadRoutePoint < ApplicationRecord
  belongs_to :road_route

  class << self
    def allowed_params
      %i[longitude latitude devise_serial_number]
    end
  end
end
