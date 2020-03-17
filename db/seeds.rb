require 'securerandom'

default_company = Company.create(name: 'SomeDefault spa')
default_kind_of_vehicles = %w[bus van truck sedan hatchback city_car].each { |vehicle_kind| VehicleKind.create(name: vehicle_kind) }
default_vehicle_kind_to_populate = VehicleKind.find_by name: 'bus'

19.times do |t|
  track_device = TrackDevice.create!(company_id: default_company.id, serial: SecureRandom.hex)
  Vehicle.create!(track_device_id: track_device.id, patent: SecureRandom.hex[0..3].upcase)
end
default_test_device = TrackDevice.create(company_id: default_company.id, serial: 'd131dd02c5e6eec4')
default_test_vehicle = Vehicle.create(
  track_device_id: default_test_device.id,
  patent: SecureRandom.hex[0..3].upcase,
  vehicle_kind_id: default_vehicle_kind_to_populate.id
)
