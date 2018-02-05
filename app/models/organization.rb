class Organization < ApplicationRecord
  include PgSearch

  has_many :jobs

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |organization|
        csv << organization.attributes.values_at(*column_names)
      end
    end
  end

  filterrific(
    default_filter_params: { sorted_by: 'organization_name_desc' },
    available_filters: [
      :sorted_by,
      :search_by,
      :with_organization_name,
      :with_organization_contact_name,
      :with_organization_contact_email,
      :with_organization_contact_phone
    ]
  )

  scope :with_organization_name_of, lambda { |organizations|
    where(organization_name: [*name])
  }

  scope :with_organization_contact_name_of, lambda { |contact|
    where(organization_contact_name: [*contact_name])
  }

  scope :with_organization_contact_email_of, lambda { |contact|
    where(organization_contact_email: [*contact_email])
  }

  scope :with_organization_contact_phone_of, lambda { |contact|
    where(organization_contact_phone: [*contact_phone])
  }

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
      when /^organization_name_/
        # Simple sort on the name colums
        order("organizations.organization_name #{ direction }")
      when /^organization_contact_name_/
        # Simple sort on the name colums
        order("organizations.organization_contact_name #{ direction }")
      when /^organization_contact_email_/
        # Simple sort on the name colums
        order("organizations.organization_contact_email #{ direction }")
      when /^organization_contact_phone_/
        # Simple sort on the name colums
        order("organizations.organization_contact_phone #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  pg_search_scope :search_by, :against => [:organization_name, :organization_contact_name, :organization_contact_email, :organization_contact_phone]
end
