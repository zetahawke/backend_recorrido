class CreateRoadRoutePoints < ActiveRecord::Migration[6.0]
  def change
    create_table :road_route_points do |t|
      t.string :latitude
      t.string :longitude
      t.references :road_route, null: false, foreign_key: true

      t.timestamps
    end
  end
end
