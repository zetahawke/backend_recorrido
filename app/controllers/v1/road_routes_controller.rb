module V1
  class RoadRoutesController < V1::ApiController
    before_action :set_road_route, only: %i[road_route_points]
    
    def index
      render json: { road_routes: RoadRoute.filter_by(filterable_params), state: :ok }, status: :ok
    rescue StandardError => e
      render json: { state: :error, message: e.message }, status: :bad_request
    end

    def road_route_points
      raise unless @road_route

      render json: { road_route: @road_route.with_points, state: :ok }, status: :ok
    rescue StandardError => e
      render json: { road_route: { road_route_points: [] }, state: :error }, status: :bad_request
    end

    private

    def filterable_params
      params.permit(:patent, :date, :destiny, :origin)
    end

    def set_road_route
      @road_route = RoadRoute.find_by(id: params[:id] || params[:road_route_id])
    end
  end
end