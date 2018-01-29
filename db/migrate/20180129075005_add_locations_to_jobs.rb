class AddLocationsToJobs < ActiveRecord::Migration[5.1]
  def change
    add_column :jobs, :location_id, :integer
    add_index :jobs, :location_id
  end
end
