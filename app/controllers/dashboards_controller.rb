class DashboardsController < ApplicationController
  before_action :set_dashboard, only: [:show]
  before_action :authenticate_user!

  # GET /dashboards
  def index
    @not_completed_job = Job.where(job_completed: false)
    @user_primary_jobs = @not_completed_job.where(primary_id: current_user.id)
    @user_backup_jobs = @not_completed_job.where(backup_id: current_user.id)
    @open_jobs = @not_completed_job.where(primary_id: nil)
    @backup_open = @not_completed_job.where.not(primary_id: nil).where.not(primary_id: current_user.id).where(backup_id: nil)
    @critical_open = []
    @open_jobs.each do |job|
      if job.job_date < 7.days.from_now
        @critical_open.push(job)
      end
    end
  end

end
