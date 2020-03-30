class RoadRoute < ApplicationRecord
  belongs_to :track_device
  belongs_to :vehicle
  has_many :road_route_points

  class << self
    def filter_by(params)
      destiny_coords = params[:destiny] == 'psn' ? RoadRoutePoint.default_init : RoadRoutePoint.default_end
      preload_data = params[:patent].blank? ? by_date(params[:date]) : by_date(params[:date]).by_vehicle_patent(params[:patent])
      preload_data.when_road_to(destiny_coords)
    end

    def when_road_to(coords = RoadRoutePoint.default_init)
      joins(:road_route_points).select do |rr|
        rr.road_route_points.first.coords == coords
      end
    end

    def by_vehicle_patent(patent)
      joins(:vehicle).where(vehicles: { patent: patent })
    end

    def by_date(date)
      where('created_at::date == ?', date.try(:to_date))
    end
  end
end
