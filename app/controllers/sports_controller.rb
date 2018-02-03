class SportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sports = Sport.all
  end

  def destroy
    @sport = Sport.find(params[:id])
    if @sport.delete
      flash[:notice] = "#{@sport.sport_name} was Deleted succesfully."
      redirect_to sports_path
    end
  end

  private

  def organization_params
    params.require(:sport).permit(:sport_name)
  end

end
