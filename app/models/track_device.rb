class TrackDevice < ApplicationRecord
  belongs_to :company
  has_one :vehicle
  has_many :road_routes
end
