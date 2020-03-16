class RoadRoute < ApplicationRecord
  belongs_to :track_device
  belongs_to :vehicle
  has_many :road_route_points
end
