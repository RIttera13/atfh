class JobsController < ApplicationController
  before_action :authenticate_user!

  # GET /jobs
  def index
    @filterrific = initialize_filterrific(
      Job,
      params[:filterrific],
      select_options: {
        with_job_organization_of: Organization.all.map(&:organization_name),
        with_job_sport_of: Sport.all.map(&:sport_name)
      }
    ) or return

    @jobs = @filterrific.find.page(params[:page])
    @users = User.all

    respond_to do |format|
      format.html
      format.js
    end

    rescue ActiveRecord::RecordNotFound => e
     puts "Had to reset filterrific params: #{ e.message }"
     redirect_to(reset_filterrific_url(format: :html)) and return

  end

  # GET /jobs/1
  def show
    @job = Job.find(params[:id])
    @users = User.all
    @start_date_time_auto = DateTime.new(@job.job_date.year, @job.job_date.month, @job.job_date.day, @job.job_time.to_time.hour, @job.job_time.to_time.min, @job.job_time.to_time.sec).strftime("%m/%d/%Y %l:%M %P")
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @sports = Sport.all
    @organizations = Organization.all
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @sports = Sport.all
    @organizations = Organization.all
  end

  # POST /jobs
  def create
    job_organization = Organization.find_by(organization_name: job_params[:job_organization])
    @job = job_organization.jobs.new(job_params)

    if @job.save
      redirect_to jobs_path, success: 'Job was successfully created.'
    else
      flash[:error] = @job.errors.full_messages
      redirect_to jobs_path
    end
  end

  # PATCH/PUT /jobs/1
  def update
    @job = Job.find(params[:id])

    if @job.update(job_params)
      redirect_back(fallback_location: root_path, success: 'Job was successfully updated.')
    else
      flash[:error] = @job.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  # DELETE /jobs/1
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, notice: 'Job was successfully destroyed.'
  end

  def accept_job
    @job = Job.find(params[:job_id])

    if @job.update(primary_id: current_user.id)
      redirect_to root_path, success: 'You have accepted the Job.'
    else
      flash[:error] = @job.errors.full_messages
      redirect_to root_path
    end
  end

  def backup_job
    @job = Job.find(params[:job_id])

    if @job.update(backup_id: current_user.id)
      redirect_to root_path, success: 'You are the Backup for the Job.'
    else
      flash[:error] = @job.errors.full_messages
      redirect_to root_path
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:job_organization, :job_address, :job_date, :job_time, :job_estimated_hours, :job_sport, :job_notes, :job_completion_notes, :job_completed, :job_start_time, :job_end_time, :job_actual_hours, :job_approved, :job_paid, :primary_id, :backup_id, :organization_id)
    end

end
