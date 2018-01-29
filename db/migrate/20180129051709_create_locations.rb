class CreateLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :locations do |t|
      t.string :location_name
      t.string :location_address
      t.string :location_contact_name
      t.string :location_contact_email
      t.string :location_contact_phone
      t.string :location_notes

      t.timestamps
    end
  end
end
