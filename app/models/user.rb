class User < ApplicationRecord
  include PgSearch
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.to_csv(options = {})
    CSV.generate(options) do |csv|
      csv << column_names
      all.each do |user|
        csv << user.attributes.values_at(*column_names)
      end
    end
  end

  has_many :primary, :class_name => 'Job', :foreign_key => 'primary_id'
  has_many :backup, :class_name => 'Job', :foreign_key => 'backup_id'

  validates :password,
    :length => { :minimum => 6, :allow_nil => true },
    :confirmation => true

  filterrific(
   default_filter_params: { sorted_by: 'firstname_desc' },
   available_filters: [
     :sorted_by,
     :search_by,
     :with_role_of
   ]
  )

  scope :with_role_of, lambda { |roles|
     where(role: [*roles])
   }


  scope :sorted_by, lambda { |sort_option|
   # extract the sort direction from the param value.
   direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
   case sort_option.to_s

   when /^firstname/
     # Simple sort on the name colums
     order("LOWER(users.firstname) #{ direction }")
   when /^lastname/
     # Simple sort on the name colums
     order("LOWER(users.lastname) #{ direction }")
   when /^email_/
     # Simple sort on the name colums
     order("LOWER(users.email) #{ direction }")
   when /^role_/
     # Simple sort on the name colums
     order("users.role #{ direction }")
   else
     raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
   end
  }

  pg_search_scope :search_by, :against => [:firstname, :lastname, :email, :role]

  enum role: [:admin, :trainer, :inactive]

end
