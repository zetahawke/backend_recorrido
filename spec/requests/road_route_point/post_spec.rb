require 'rails_helper'

begin
  company = Company.create!( name: 'Test Company' )
  vehicle_kind = VehicleKind.create!( name: 'Test Vehicle Kind' )
  trackin_device = TrackDevice.create!( company_id: company.id, serial: 'd131dd02c5e6eec4')
  vehicle = Vehicle.create!(vehicle_kind_id: vehicle_kind.id, track_device_id: trackin_device.id, patent: 'AB1234')
rescue StandardError => _e
  puts _e.message
end

stub_road_route_waypoint = {
  "devise_serial_number": "d131dd02c5e6eec4",
  "longitude": -70.69075584411621,
  "latitude": -33.45382270754665
}.with_indifferent_access


describe "post a road route point", type: :request do
  before do
    post '/v1/road_route_points.json', params: stub_road_route_waypoint
  end

  it "returns the road route point's latitude" do
    expect(JSON.parse(response.body)['road_route_point']['latitude'].to_s).to eq(stub_road_route_waypoint['latitude'].to_s)
  end

  it "returns the road route point's longitude" do
    expect(JSON.parse(response.body)['road_route_point']['longitude'].to_s).to eq(stub_road_route_waypoint['longitude'].to_s)
  end

  it "returns the road route point's created_at" do
    expect(JSON.parse(response.body)['road_route_point']['created_at'].to_datetime).to be_instance_of(DateTime)
  end

  it "returns correct status code" do
    expect(response.code).to eq("200")
  end

  it "returns a created status" do
    expect(response).to have_http_status(:ok)
  end
end
