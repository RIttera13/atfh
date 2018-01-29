class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :job_location
      t.string :job_address
      t.string :job_date
      t.string :job_time
      t.string :job_estimated_hours
      t.string :job_sport
      t.string :job_notes
      t.boolean :job_assigned, default: false
      t.boolean :job_closed, default: false

      t.timestamps
    end
  end
end
