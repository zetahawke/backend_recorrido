module V1
  class RoadRoutePointsController < ApplicationController
    before_action :idetify_device, only: %i [create]
    before_action :idetify_vehicle, only: %i [create]
    before_action :prev_route, only: %i [create]

    def create
      @route = RoadRoute.create(vehicle_id: @vehicle.id, track_device_id: @track_device.id) unless @route
      road_route_point = @route.road_route_points.create(road_route_points_params.except(:devise_serial_number))
      respond json: { road_route_point: road_route_point, state: :ok }, status: :ok
    rescue StandardError => e
      respond json: { state: :error, message: e.message }, status: :bad_request
    end

    private
    
    def identify_device
      @device = Device.find_by(serial: road_route_points_params[:devise_serial_number])
    end
    
    def identify_vehicle
      @vehicle = @device.vehicle
    end

    def prev_route
      @route = RoadRoute.find_by(vehicle_id: @vehicle.id, track_device_id: @track_device.id)
    end

    def road_route_points_params
      params.permit(RoadRoutePoint.allowed_params)
    end
  end
end