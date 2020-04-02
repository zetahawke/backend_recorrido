class GeoReferenceService
  attr_accessor :latitude, :longitude

  def initialize(long_lat = [])
    longitude = long_lat[0]
    latitude = long_lat[1]
  end

  def coords
    [longitude, latitude]
  end

  def is_near_of?(from_coords, meters = 100)
    (Geocoder::Calculations.distance_between(from_coords, coords) / 1.6 * 1_000) <= meters
  end
end