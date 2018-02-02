class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :job_client
      t.string :job_address
      t.string :job_date
      t.string :job_time
      t.string :job_estimated_hours
      t.string :job_sport
      t.string :job_notes
      t.string :job_completion_notes
      t.string :job_start_time
      t.string :job_end_time
      t.boolean :job_completed, default: false
      t.boolean :job_accepted, default: false
      t.boolean :job_paid, default: false
      t.references :primary
      t.references :backup
      t.references :client, foreign_key: true

      t.timestamps
    end
  end
end
