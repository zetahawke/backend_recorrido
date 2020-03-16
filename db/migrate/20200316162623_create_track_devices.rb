class CreateTrackDevices < ActiveRecord::Migration[6.0]
  def change
    create_table :track_devices do |t|
      t.references :company, null: false, foreign_key: true
      t.string :serial
      t.boolean :enable, default: true

      t.timestamps
    end
  end
end
