class CreateVehicles < ActiveRecord::Migration[6.0]
  def change
    create_table :vehicles do |t|
      t.references :vehicle_kind
      t.references :track_device
      t.string :patent

      t.timestamps
    end
  end
end
