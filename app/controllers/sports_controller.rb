class SportsController < ApplicationController
  before_action :authenticate_user!

  def index
    @sports = Sport.all
  end

  def new
    @sport = Sport.new
  end

  def create
    @sport = Sport.new(sports_params)

    if @sport.save
      redirect_to sports_path, success: 'Organization was successfully created.'
    else
      flash[:error] = @sport.errors.full_messages
      redirect_to sports_path
    end
  end

  def destroy
    @sport = Sport.find(params[:id])
    if @sport.delete
      flash[:notice] = "#{@sport.sport_name} was Deleted succesfully."
      redirect_to sports_path
    end
  end

  private

  def sports_params
    params.require(:sport).permit(:sport_name)
  end

end
