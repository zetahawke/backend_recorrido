class RoadRoute < ApplicationRecord
  belongs_to :track_device
  belongs_to :vehicle
end
