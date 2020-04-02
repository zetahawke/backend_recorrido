class RoadRoute < ApplicationRecord
  belongs_to :track_device
  belongs_to :vehicle
  has_many :road_route_points

  class << self
    def filter_by(params)
      origin_coords = params[:origin] == 'stg' ? RoadRoutePoint.default_init : RoadRoutePoint.default_end
      preload_data = params[:patent].blank? ? by_date(params[:date]) : by_date(params[:date]).by_vehicle_patent(params[:patent])
      presentational_map(preload_data.when_road_to(origin_coords))
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
      where('road_routes.created_at::date = ?', date.try(:to_date))
    end

    def presentational_map(data)
      data ||= where('')
      data.map do |road_route|
        {
          patent: road_route.vehicle.patent,
          out: road_route.out,
          arrive: road_route.arrive,
          status: road_route.status
        }
      end
    end
  end

  def out
    return if road_route_points.blank?

    road_route_points.first.created_at
  end

  def arrive
    return if road_route_points.blank?

    current_last_point = road_route_points.last
    current_last_point.created_at if GeoReferenceService.new(current_last_point.coords).is_near_of?(destiny_coords, 100)
  end

  def status
    return if road_route_points.blank?

    if arrive
      'finished'
    else !arrive
      current_last_point = road_route_points.last
      if DateTime.current > current_last_point.created_at + 15.minutes
        'incomplete'
      else
        'in_route'
      end
    end
  end

  def destiny_coords
    return if road_route_points.blank?

    road_route_points.first.coords == RoadRoutePoint.default_init ? RoadRoutePoint.default_end : RoadRoutePoint.default_end    
  end

  def with_points
    serializable_hash(include: [:road_route_points])
  end
end
