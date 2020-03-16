module V1
  class RoadRoutePointsController < V1::ApiController
    before_action :identify_device, only: %i[create]
    before_action :identify_vehicle, only: %i[create]
    before_action :prev_route, only: %i[create]

    def create
      @route = RoadRoute.create(vehicle_id: @vehicle.id, track_device_id: @device.id) unless @route
      road_route_point = @route.road_route_points.create(road_route_points_params.except(:devise_serial_number))
      render json: { road_route_point: road_route_point, state: :ok }, status: :ok
    rescue StandardError => e
      render json: { state: :error, message: e.message }, status: :bad_request
    end

    private
    
    def identify_device
      @device = TrackDevice.find_by(serial: road_route_points_params[:devise_serial_number])
    end
    
    def identify_vehicle
      @vehicle = Vehicle.joins(:track_device).find_by(track_devices: { serial: road_route_points_params[:devise_serial_number] })
    end
    
    def prev_route
      @route = RoadRoute.find_by(vehicle_id: @vehicle.id, track_device_id: @device.id)
    end

    def road_route_points_params
      params.permit(RoadRoutePoint.allowed_params)
    end
  end
end