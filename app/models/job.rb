class Job < ApplicationRecord
  belongs_to :location
  belongs_to :primary, :class_name => 'User', optional: true
  belongs_to :backup, :class_name => 'User', optional: true

  include PgSearch

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |job|
        csv << job.attributes.values_at(*column_names)
      end
    end
  end

  filterrific(
    default_filter_params: { with_date_of_gte: 1.month.ago, sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :with_job_locations,
      :with_job_sport,
      :with_date_of_gte,
      :with_date_of_lt
    ]
  )

  scope :with_job_locations, lambda { |locations|
     where(job_location: [*locations])
   }

   scope :with_job_sports, lambda { |sports|
      where(job_sport: [*sports])
    }

    # always include the lower boundary for semi open intervals
  scope :with_date_of_gte, lambda { |reference_time|
   where('jobs.created_at >= ?', (reference_time.to_datetime + 5.hours))
  }

  # always exclude the upper boundary for semi open intervals
  scope :with_date_of_lt, lambda { |reference_time|
   where('jobs.created_at <= ?', (reference_time.to_datetime + 5.hours))
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^job_date_/
      # Simple sort on the name colums
      order("LOWER(jobs.job_date) #{ direction }")
    when /^job_sport_/
      # Simple sort on the name colums
      order("LOWER(jobs.job_sport) #{ direction }")
    when /^job_location_/
      # Simple sort on the name colums
      order("LOWER(jobs.job_location) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
end
