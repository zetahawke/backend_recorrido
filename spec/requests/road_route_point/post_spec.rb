require 'rails_helper'

stub_road_route_waypoint = {
  "devise_serial_number": "d131dd02c5e6eec4",
  "longitude": -70.69075584411621,
  "latitude": -33.45382270754665
}.with_indifferent_access

describe "post a road route point", type: :request do
  before do
    post '/api/v1/road_route', params: stub_road_route_waypoint
  end

  it "returns the road route point's latitude" do
    expect(JSON.parse(response.body)['road_route_point']['latitude'].to_s).to eq(stub_road_route_waypoint['latitude'].to_s)
  end

  it "returns the road route point's longitude" do
    expect(JSON.parse(response.body)['road_route_point']['longitude'].to_s).to eq(stub_road_route_waypoint['longitude'].to_s)
  end

  it "returns the road route point's created_at" do
    expect(JSON.parse(response.body)['road_route_point']['created_at'].to_datetime).to eq(stub_road_route_waypoint['created_at'].to_datetime)
  end

  it "returns correct status code" do
    expect(response.code).to eq("200")
  end

  it "returns a created status" do
    expect(response).to have_http_status(:ok)
  end
end
