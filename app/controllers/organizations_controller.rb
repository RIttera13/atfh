class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @filterrific = initialize_filterrific(
      Organization,
      params[:filterrific],
      select_options: {
      }
    ) or return

    @organizations = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @job = Job.find(params[:id])
    @users = User.all
    @start_date_time_auto = DateTime.new(@job.job_date.year, @job.job_date.month, @job.job_date.day, @job.job_time.to_time.hour, @job.job_time.to_time.min, @job.job_time.to_time.sec).strftime("%m/%d/%Y %l:%M %P")
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      redirect_to organizations_path, success: 'Organization was successfully created.'
    else
      flash[:error] = @organization.errors.full_messages
      redirect_to organizations_path
    end
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.update(organization_params)
      flash[:success] = "Organization updated."
      redirect_to organizations_path
    else
      flash.now[:alert] = "Error saving Organizations changes. Please try again."
      render :edit
    end
  end

  def destroy
    @organization = Organization.find(params[:id])
    if @organization.update(organization_active: false)
      flash[:notice] = "#{@organization.organization_name} was De-Activated succesfully."
      redirect_to organizations_path
    end
  end

  def re_activate
    @organization = Organization.find(params[:id])

    @organization.update(:organization_active => true)
    flash[:success] = "Organization has been Re-Activated."
    redirect_to organizations_path
  end

  private

  def organization_params
    params.require(:organization).permit(:organization_name, :organization_address, :organization_contact_name, :organization_contact_email, :organization_contact_phone, :organization_notes, :organization_active)
  end

end
