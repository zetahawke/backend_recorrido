module V1
  class RoadRoutesController < V1::ApiController
    def show
      render json: { RoadRoute.filter_by(filterable_params) }
    end

    private

    def filterable_params
      params.permit(:patent, :date, :destiny)
    end
  end
end