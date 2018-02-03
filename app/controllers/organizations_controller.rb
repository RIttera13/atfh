class OrganizationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @organizations = Organization.all
  end

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])

    if @organization.save
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

  private

  def organization_params
    params.require(:organization).permit(:organization_name, :organization_address, :organization_contact_name, :organization_contact_email, :organization_contact_phone, :organization_notes, :organization_active)
  end

end
