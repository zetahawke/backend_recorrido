module V1
  class RoadRoutePointsController < V1::ApiController
    def create
      road_route_point = RoadRoutePoint.create_by_params(road_route_points_params)
      render json: { road_route_point: road_route_point, state: :ok }, status: :ok
    rescue StandardError => e
      render json: { state: :error, message: e.message }, status: :bad_request
    end

    def road_route_points_params
      params.permit(RoadRoutePoint.allowed_params)
    end
  end
end