require 'rails_helper'

begin
  company = Company.create!( name: 'Test Company' )
  vehicle_kind = VehicleKind.create!( name: 'Test Vehicle Kind' )
  trackin_device = TrackDevice.create!( company_id: company.id, serial: 'd131dd02c5e6eec4')
  vehicle = Vehicle.create!(vehicle_kind_id: vehicle_kind.id, track_device_id: trackin_device.id, patent: 'AB1234')
rescue StandardError => _e
  puts _e.message
end

stub_road_route_filter_params = {
  "date": "23-03-2020",
  "patent": 'ABC123',
  "destiny": 'psn'
}.with_indifferent_access


describe "filter road routes", type: :request do
  before do
    get '/v1/road_routes.json', params: stub_road_route_filter_params
  end

  it "returns the road route point's latitude" do
    expect(JSON.parse(response.body)['road_routes'].first).to not_be_empty
  end

  it "returns correct status code" do
    expect(response.code).to eq("200")
  end

  it "returns a created status" do
    expect(response).to have_http_status(:ok)
  end
end
