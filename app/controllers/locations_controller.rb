class LocationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @filterrific = initialize_filterrific(
      Location,
      params[:filterrific],
      select_options: {
      }
    ) or return

    @locations = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)

    if @location.save
      redirect_to locations_path, success: 'Locations was successfully created.'
    else
      flash[:error] = @location.errors.full_messages
      redirect_to locations_path
    end
  end

  def edit
    @location = Location.find(params[:id])
  end

  def update
    @location = Location.find(params[:id])

    if @location.update(location_params)
      flash[:success] = "Location updated."
      redirect_to locations_path
    else
      flash.now[:alert] = "Error saving Locations changes. Please try again."
      render :edit
    end
  end

  def destroy
    @location = Location.find(params[:id])
    if @location.delete
      flash[:notice] = "#{@location.location_name} was Deleted succesfully."
      redirect_to locations_path
    end
  end

  private

  def location_params
    params.require(:location).permit(:location_name, :location_street, :location_city, :location_state, :location_zip)
  end

end
