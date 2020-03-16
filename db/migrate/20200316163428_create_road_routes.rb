class CreateRoadRoutes < ActiveRecord::Migration[6.0]
  def change
    create_table :road_routes do |t|
      t.string :latitude
      t.string :longitude
      t.references :track_device, null: false, foreign_key: true
      t.references :vehicle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
