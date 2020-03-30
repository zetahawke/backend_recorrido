module V1
  class RoadRoutesController < V1::ApiController
    def index
      render json: { road_routes: RoadRoute.filter_by(filterable_params), state: :ok }, status: :ok
    rescue StandardError => e
      render json: { state: :error, message: e.message }, status: :bad_request
    end

    private

    def filterable_params
      params.permit(:patent, :date, :destiny)
    end
  end
end