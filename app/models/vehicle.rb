class Vehicle < ApplicationRecord
  belongs_to :track_device
  has_one :company, through: :track_device

  validates :patent, presence: true, uniqueness: true
  validates :track_device_id, presence: true, uniqueness: true
end
