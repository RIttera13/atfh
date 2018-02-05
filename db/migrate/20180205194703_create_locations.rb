class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :location_street
      t.string :location_city
      t.string :location_state
      t.string :location_zip

      t.timestamps
    end
  end
end
