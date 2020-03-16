class Vehicle < ApplicationRecord
  belongs_to :track_device
  belongs_to :company, through: :track_device
end
