class RoadRoutePoint < ApplicationRecord
  belongs_to :road_route

  class << self
    def allowed_params
      %i[longitude latitude devise_serial_number]
    end

    def points_by_coords(coords = default_init)
      lon, lat = coords
      where(latitude: lat, longitude: lon)
    end

    def default_init
      # long lat
      ['-70.69075584411621','-33.45382270754665']
    end

    def default_end
      # long lat
      ['-71.04652404785156', '-34.791074253715365']
    end
  end

  def coords
    [longitude, latitude]
  end
end
