class Location < ApplicationRecord
  include PgSearch

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |location|
        csv << location.attributes.values_at(*column_names)
      end
    end
  end

  filterrific(
    default_filter_params: { sorted_by: 'location_name_desc' },
    available_filters: [
      :sorted_by,
      :search_by,
      :with_location_name,
    ]
  )

  scope :with_location_name_of, lambda { |locations|
    where(location_name: [*name])
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^location_name_/
        # Simple sort on the name colums
        order("locations.location_name #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  pg_search_scope :search_by, :against => [:location_name]
end
