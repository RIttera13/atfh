class JobsController < ApplicationController
  before_action :authenticate_user!

  # GET /jobs
  def index
    @filterrific = initialize_filterrific(
      Job,
      params[:filterrific],
      select_options: {
        with_job_locations: Location.all.map(&:location_name),
        with_job_sport: Sport.all.map(&:sport_name)
      }
    ) or return

    @jobs = Job.all
    @users = User.all
  end

  # GET /jobs/1
  def show
    @job = Job.find(params[:id])
    @users = User.all
  end

  # GET /jobs/new
  def new
    @job = Job.new
    @sports = Sport.all
    @locations = Location.all
  end

  # GET /jobs/1/edit
  def edit
    @job = Job.find(params[:id])
    @sports = Sport.all
    @locations = Location.all
  end

  # POST /jobs
  def create
    job_location = Location.find_by(location_name: job_params[:job_location])
    @job = job_location.jobs.new(job_params)

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
      redirect_to jobs_path, success: 'Job was successfully updated.'
    else
      flash[:error] = @job.errors.full_messages
      redirect_to jobs_path
    end
  end

  # DELETE /jobs/1
  def destroy
    @job = Job.find(params[:id])
    @job.destroy
    redirect_to jobs_path, notice: 'Job was successfully destroyed.'
  end

  def accept_job
    @job = Job.find(params[:job])

    if @job.update(primary_id: params[:current_user])
      redirect_to root, success: 'You have accepted the Job.'
    else
      flash[:error] = @job.errors.full_messages
      redirect_to root
    end
  end

  private
    # Only allow a trusted parameter "white list" through.
    def job_params
      params.require(:job).permit(:job_location, :job_address, :job_date, :job_time, :job_estimated_hours, :job_sport, :job_notes, :job_completion_notes, :job_completed, :job_start_time, :job_end_time, :job_accepted, :job_paid, :primary_id, :backup_id, :location_id)
    end

end
