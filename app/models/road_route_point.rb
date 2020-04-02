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

    def create_by_params(params)
      current_route = find_a_prev_route(params[:devise_serial_number])
      prev_point = current_route.road_route_points.last
      if GeoReferenceService.new(prev_point.coords).is_near_of?([params[:longitude], params[:latitude]])
        prev_point
      else
        current_route.road_route_points.create(params.except(:devise_serial_number))
      end
    end

    private

    def identify_device(devise_serial_number)
      TrackDevice.find_by(serial: devise_serial_number)
    end
    
    def identify_vehicle(devise_serial_number)
      Vehicle.joins(:track_device).find_by(track_devices: { serial: devise_serial_number })
    end
    
    def find_a_prev_route(devise_serial_number)
      device = identify_device(devise_serial_number)
      vehicle = identify_vehicle(devise_serial_number)
      route = RoadRoute.find_by(vehicle_id: vehicle.id, track_device_id: device.id)
      route = RoadRoute.create(vehicle_id: vehicle.id, track_device_id: device.id) unless route || route.try(:status) != 'finished'
      route
    end
  end

  def coords
    [longitude, latitude]
  end

  def next_near_point
    road_route.road_route_points.where('road_route_points.id > ?', id).sort.first
  end

  def status
    if time_between_points >= 120.0
      'stop'
    else
      'pass'
    end
  end
  
  def time_between_points
    current_next_near_point = next_near_point
    return 0 unless current_next_near_point

    current_next_near_point.created_at - created_at
  end
end
