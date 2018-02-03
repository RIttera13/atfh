class CreateJobs < ActiveRecord::Migration[5.1]
  def change
    create_table :jobs do |t|
      t.string :job_organization
      t.string :job_address
      t.date :job_date
      t.string :job_time
      t.integer :job_estimated_hours
      t.string :job_sport
      t.string :job_notes
      t.string :job_completion_notes
      t.datetime :job_start_time
      t.datetime :job_end_time
      t.integer :job_actual_hours, default: 0
      t.boolean :job_completed, default: false
      t.boolean :job_approved, default: false
      t.boolean :job_paid, default: false
      t.references :primary
      t.references :backup
      t.references :organization, foreign_key: true

      t.timestamps
    end
  end
end
