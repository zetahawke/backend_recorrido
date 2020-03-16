class RemoveColumnsLatitudeAndLongitudeFromRoadRoutes < ActiveRecord::Migration[6.0]
  def change
    remove_column :road_routes, :latitude
    remove_column :road_routes, :longitude
  end
end
