class Job < ApplicationRecord
  include PgSearch

  belongs_to :organization
  belongs_to :primary, :class_name => 'User', optional: true
  belongs_to :backup, :class_name => 'User', optional: true

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |job|
        csv << job.attributes.values_at(*column_names)
      end
    end
  end

  filterrific(
    default_filter_params: { sorted_by: 'job_date_desc' },
    available_filters: [
      :sorted_by,
      :with_job_organization_of,
      :with_job_sport_of,
      :with_job_date_gte,
      :with_job_date_lt
    ]
  )

  scope :with_job_organization_of, lambda { |organizations|
    where(job_organization: [*organizations])
  }

  scope :with_job_sport_of, lambda { |sports|
    where(job_sport: [*sports])
  }

    # always include the lower boundary for semi open intervals
  scope :with_job_date_gte, lambda { |reference_time|
   where('jobs.job_date >= ?', reference_time.to_date)
  }

  # always exclude the upper boundary for semi open intervals
  scope :with_job_date_lt, lambda { |reference_time|
   where('jobs.job_date <= ?', reference_time.to_date)
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^job_date_/
        # Simple sort on the name colums
        order("jobs.job_date #{ direction }")
      when /^job_sport_/
        # Simple sort on the name colums
        order("jobs.job_sport #{ direction }")
      when /^job_organization_/
        # Simple sort on the name colums
        order("jobs.job_organization #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
end
