class TrackDevice < ApplicationRecord
  belongs_to :company
  has_one :vehicle
  has_many :road_routes

  validates :serial, presence: true, uniqueness: true
end
