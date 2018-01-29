class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable



  has_many :primary_jobs, :class_name => 'Job', :foreign_key => 'primary_id'
  has_many :backup_jobs, :class_name => 'Job', :foreign_key => 'backup_id'

  enum role: [:admin, :trainer, :inactive]

end
